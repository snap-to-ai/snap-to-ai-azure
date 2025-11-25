# Firewall Automation Script

The sample script `scripts/Configure-SnapToAIFirewall.ps1` automates the creation of outbound Windows Defender Firewall rules for the hosts listed in [Network Allowlist](./network-allowlist.md). Use it when you need to provision a locked-down test device quickly (for example, during Microsoft Store flight validation).

> [!IMPORTANT]
> This script is provided **as-is**, without warranties or support commitments. Validate every rule in your own environment before deploying it to production devices.

## Requirements

- Windows 10/11 with Windows Defender Firewall enabled
- PowerShell 5.1 (or later) running **as Administrator**
- DNS resolution for each required FQDN
- Optional: connectivity to your own Azure OpenAI or Azure AI Foundry endpoints if you pass custom hosts

## Usage

1. Clone or download this repository and open an elevated PowerShell session in the repo root.
2. Run the script with the Azure host names you want to allow:
   ```powershell
   pwsh -ExecutionPolicy Bypass -File .\scripts\Configure-SnapToAIFirewall.ps1 `
       -AzureOpenAIHost contoso-openai.openai.azure.com `
       -AzureAIFoundryHost project123.services.ai.azure.com
   ```
3. Review the verbose output. The script removes prior rules with the same prefix, resolves IP addresses, and creates IPv4/IPv6 rules in chunks of up to 100 addresses.
4. Validate that the new rules exist:
   ```powershell
   Get-NetFirewallRule -DisplayName "Snap to AI Allowlist*" |
       Get-NetFirewallAddressFilter |
       Format-Table -AutoSize
   ```
5. When you finish testing, remove the rules:
   ```powershell
   pwsh -ExecutionPolicy Bypass -File .\scripts\Configure-SnapToAIFirewall.ps1 -Mode Remove
   ```

## Parameters

| Parameter | Description |
| --- | --- |
| `-Mode` | `Apply` (default) creates rules, `Remove` deletes rules created by this script. |
| `-AzureOpenAIHost` | One or more Azure OpenAI resource FQDNs (for example, `snap2llm.openai.azure.com`). |
| `-AzureAIFoundryHost` | Azure AI Foundry (Azure AI Inference) host names. Optional. |
| `-AdditionalHosts` | Extra FQDNs (custom CDN, proxy, etc.). Optional. |
| `-RulePrefix` | Custom display-name prefix when you need multiple rule sets side by side. |
| `-ChunkSize` | Maximum number of IP addresses per firewall rule (default: 100). |
| `-SkipIPv6` | Skip IPv6 allow rules when you only want IPv4. |

## Operational Notes

- DNS-driven IP ranges change frequently. Rerun the script whenever Microsoft updates the service endpoints or when your environment rotates IPs.
- The script does not validate reachability—for each new host, run `Resolve-DnsName` and `Test-NetConnection` manually to confirm connectivity.
- If your organization manages firewall rules via Group Policy, import the generated IP ranges there rather than running the script directly on production devices.
