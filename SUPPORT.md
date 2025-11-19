# Support Guide

Thank you for using Snap to AI for Microsoft Azure. The Microsoft Store build is supported through GitHub Issues in this repository. Please review the guidance below before opening a ticket.

## Before You File an Issue
- Review the [Quickstart](docs/quickstart.md) and [Troubleshooting](docs/troubleshooting.md) guides.
- Confirm you are running the latest version from the Microsoft Store.
- Gather the following information:
  - App version (Settings → About → Version).
  - Windows edition and build number (Win + R → `winver`).
  - Azure endpoint type (Azure OpenAI or Azure AI Foundry) and region.
  - Network restrictions (proxy, firewall allowlist, VPN, etc.).
  - Steps to reproduce the problem and what you expected to happen.
  - Logs from `%LocalAppData%\SnapToAIForMicrosoftAzure\SnapToAIForMicrosoftAzure.log` (sanitise sensitive data before sharing).

## Opening a Support Ticket
1. Navigate to **Issues → New Issue**.
2. Select the **Bug report** or **Feature request** template.
3. Provide as much detail as possible, including screenshots or screen recordings.
4. Attach logs and anonymised instructions if requested by the template.

## Response Targets
- Support is provided by a solo developer and handled on a best-effort basis.
- The aspirational goal is an initial response within **3 business days** so that enterprise teams can plan their next steps, but replies may take longer during heavy workload periods.
- Complex incidents (e.g., Azure policy conflicts) may require additional follow-up through private channels.

## Privacy & Sensitive Data
Do not upload raw screenshots containing confidential information. Redact or mask sensitive areas before sharing. If you need to provide secure materials, coordinate with us via the contact method listed in [`SECURITY.md`](SECURITY.md).
