#requires -RunAsAdministrator
#requires -Version 5.1
<#!
.SYNOPSIS
    Registers HTTPS firewall allow rules required by Snap to AI for Microsoft Azure.
.DESCRIPTION
    Resolves the required FQDNs listed in publish/docs/network-allowlist.md and
    creates outbound TCP/443 allow rules for the resulting IP addresses. Existing rules with
    the same prefix are removed automatically. The script is intended to help Store flight testers
    limit their network exposure to the documented destinations.
.PARAMETER Mode
    Apply (default): create rules. Remove: delete rules previously created by this script.
.PARAMETER AzureOpenAIHost
    FQDN of the Azure OpenAI resource you use, e.g., contoso-openai.openai.azure.com.
.PARAMETER AzureAIFoundryHost
    Hostname for Azure AI Foundry (Azure AI Inference). Specify only if you call that endpoint.
.PARAMETER AdditionalHosts
    Optional FQDNs to allow in addition to the baseline list (for example, custom CDN or proxy hosts).
.PARAMETER RulePrefix
    Display name prefix for firewall rules. Change this when you manage multiple environments.
.PARAMETER ChunkSize
    Maximum number of IP addresses per rule. Defaults to 100 to stay under the Windows Defender limit (255).
.PARAMETER SkipIPv6
    Do not create IPv6 rules. Use when you only want to allow IPv4 addresses.
.EXAMPLE
    # Create rules for the contoso-openai Azure OpenAI resource
    .\Configure-SnapToAIFirewall.ps1 -AzureOpenAIHost contoso-openai.openai.azure.com
.EXAMPLE
    # Remove rules created by this script
    .\Configure-SnapToAIFirewall.ps1 -Mode Remove
#>

[CmdletBinding()]
param(
    [ValidateSet('Apply','Remove')]
    [string]$Mode = 'Apply',
    [string[]]$AzureOpenAIHost,
    [string[]]$AzureAIFoundryHost,
    [string[]]$AdditionalHosts,
    [string]$RulePrefix = 'Snap to AI for Microsoft Azure Allowlist',
    [ValidateRange(1,255)]
    [int]$ChunkSize = 100,
    [switch]$SkipIPv6
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-BaseHosts {
    [CmdletBinding()]
    param()

    $hostMap = [System.Collections.Generic.List[pscustomobject]]::new()

    $authHosts = @(
        'login.microsoftonline.com',
        'login.windows.net',
        'login.live.com',
        'logincdn.msauth.net',
        'aadcdn.msftauth.net'
    )
    $storeHosts = @(
        'displaycatalog.mp.microsoft.com',
        'purchase.mp.microsoft.com',
        'licensing.mp.microsoft.com',
        'storeedgefd.dsx.mp.microsoft.com'
    )
    $cdnHosts = @('res.cdn.office.net')

    foreach ($h in $authHosts) {
        $hostMap.Add([pscustomobject]@{ Category = 'Auth'; Host = $h })
    }
    foreach ($h in $storeHosts) {
        $hostMap.Add([pscustomobject]@{ Category = 'Store'; Host = $h })
    }
    foreach ($h in $cdnHosts) {
        $hostMap.Add([pscustomobject]@{ Category = 'CDN'; Host = $h })
    }

    return $hostMap
}

function Add-Hosts {
    param(
        [System.Collections.Generic.List[pscustomobject]]$Target,
        [string]$Category,
        [string[]]$Hosts
    )

    foreach ($h in $Hosts) {
        if ([string]::IsNullOrWhiteSpace($h)) { continue }
        $Target.Add([pscustomobject]@{ Category = $Category; Host = $h.Trim() })
    }
}

function Resolve-HostAddress {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$HostName,
        [switch]$IncludeIPv6
    )

    $addresses = [System.Collections.Generic.List[string]]::new()
    foreach ($recordType in @('A','AAAA')) {
        if ($recordType -eq 'AAAA' -and -not $IncludeIPv6) { continue }
        try {
            $records = Resolve-DnsName -Name $HostName -Type $recordType -ErrorAction Stop
            foreach ($record in $records) {
                $ipProperty = $record.PSObject.Properties['IPAddress']
                if (-not $ipProperty -or -not $ipProperty.Value) {
                    continue
                }

                try {
                    $ipObj = [System.Net.IPAddress]::Parse($ipProperty.Value.ToString())
                    $addresses.Add($ipObj.ToString())
                } catch {
                    Write-Verbose "Skipped value that could not be parsed as an IP address: $($ipProperty.Value)"
                }
            }
        } catch {
            if ($recordType -eq 'A') {
                Write-Warning "Failed to resolve host via DNS: $HostName ($_)." }
        }
    }
    $uniqueList = [System.Collections.Generic.List[string]]::new()
    $seen = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

    foreach ($addrValue in $addresses) {
        if ($seen.Add($addrValue)) {
            $uniqueList.Add($addrValue)
        }
    }

    return ,($uniqueList.ToArray())
}

function Remove-ExistingRules {
    param([string]$Prefix)
    $existing = Get-NetFirewallRule -DisplayName "$Prefix*" -ErrorAction SilentlyContinue
    if ($existing) {
        $existing | Remove-NetFirewallRule
        Write-Host "Removed existing rules: " -NoNewline
        Write-Host ($existing.DisplayName -join ', ')
    }
}

function New-AllowRule {
    param(
        [string]$RuleName,
        [string[]]$RemoteAddress
    )

    $result = [System.Collections.Generic.List[pscustomobject]]::new()

    $validated = [System.Collections.Generic.List[pscustomobject]]::new()
    foreach ($addr in $RemoteAddress) {
        if ([string]::IsNullOrWhiteSpace($addr)) { continue }
        try {
            $ipObj = [System.Net.IPAddress]::Parse($addr.Trim())
            $validated.Add([pscustomobject]@{
                Address = $ipObj.ToString()
                Family  = $ipObj.AddressFamily
            })
        } catch {
            Write-Verbose "${RuleName}: Skipped value that could not be parsed as an IP address: $addr"
        }
    }

    if ($validated.Count -eq 0) {
        Write-Verbose "${RuleName}: No valid IP addresses were found. Rule creation skipped."
        return $result
    }

    $groups = $validated | Group-Object -Property Family
    foreach ($group in $groups) {
        $familyLabel = if ($group.Name -eq [System.Net.Sockets.AddressFamily]::InterNetworkV6) { 'IPv6' } else { 'IPv4' }
        $ruleDisplayName = if ($familyLabel -eq 'IPv6') { "${RuleName} (IPv6)" } else { $RuleName }
        $addressesForRule = $group.Group | ForEach-Object { $_.Address }

        Write-Verbose ("{0}: Creating rule for IPs ({1}) -> {2}" -f $ruleDisplayName, $familyLabel, ($addressesForRule -join ', '))

        try {
            New-NetFirewallRule `
                -DisplayName $ruleDisplayName `
                -Direction Outbound `
                -Action Allow `
                -Profile Any `
                -Protocol TCP `
                -RemotePort 443 `
                -RemoteAddress $addressesForRule `
                -Enabled True `
                -Description 'Snap to AI for Microsoft Azure flight testing. See publish/docs/network-allowlist.md.' | Out-Null

            $result.Add([pscustomobject]@{
                Rule = $ruleDisplayName
                Addresses = ($addressesForRule -join ', ')
            })
        } catch {
            throw "New-NetFirewallRule failed: $ruleDisplayName | Addresses=$($addressesForRule -join ', ') | $($_.Exception.Message)"
        }
    }

    return $result
}

$allHosts = Get-BaseHosts

if ($AzureOpenAIHost) {
    Add-Hosts -Target $allHosts -Category 'AzureOpenAI' -Hosts $AzureOpenAIHost
} else {
    Write-Warning 'No Azure OpenAI host name provided. Pass -AzureOpenAIHost when needed.'
}
if ($AzureAIFoundryHost) {
    Add-Hosts -Target $allHosts -Category 'AzureAIFoundry' -Hosts $AzureAIFoundryHost
}
if ($AdditionalHosts) {
    Add-Hosts -Target $allHosts -Category 'Additional' -Hosts $AdditionalHosts
}

$allHosts = $allHosts | Sort-Object -Property Host -Unique

if ($Mode -eq 'Remove') {
    Remove-ExistingRules -Prefix $RulePrefix
    Write-Host 'Removed all rules with the specified prefix.'
    return
}

Remove-ExistingRules -Prefix $RulePrefix

$summary = [System.Collections.Generic.List[pscustomobject]]::new()

foreach ($entry in $allHosts) {
    $resolved = Resolve-HostAddress -HostName $entry.Host -IncludeIPv6:(-not $SkipIPv6)
    if (-not $resolved -or $resolved.Count -eq 0) {
        Write-Warning "Skipped host because no IP addresses could be resolved: $($entry.Host)"
        continue
    }

    $chunks = [System.Collections.Generic.List[string[]]]::new()
    for ($index = 0; $index -lt $resolved.Count; $index += $ChunkSize) {
        $endIndex = [Math]::Min($index + $ChunkSize - 1, $resolved.Count - 1)
        if ($index -eq $endIndex) {
            $chunk = @($resolved[$index])
        } else {
            $chunk = $resolved[$index..$endIndex]
        }
        $chunks.Add([string[]]$chunk)
    }

    for ($i = 0; $i -lt $chunks.Count; $i++) {
        $ruleName = "{0} - {1} #{2}" -f $RulePrefix, $entry.Host, ($i + 1)
        $createdRules = New-AllowRule -RuleName $ruleName -RemoteAddress $chunks[$i]
        foreach ($created in $createdRules) {
            $summary.Add([pscustomobject]@{
                Host = $entry.Host
                Addresses = $created.Addresses
                Rule = $created.Rule
            })
        }
    }
}

if ($summary.Count -eq 0) {
    Write-Warning 'No firewall rules were generated. Please verify the FQDN list and DNS resolution.'
} else {
    Write-Host "Created rules: $($summary.Count)"
    $summary | Format-Table -AutoSize
}
