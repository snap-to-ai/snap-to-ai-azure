# Support Guide

Thank you for using Snap to AI. The Microsoft Store build is supported through GitHub Issues in this repository. Please review the guidance below before opening a ticket.

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

## Reporting Inappropriate AI Output (Store Policy 11.16)
When Snap to AI generates content that violates your code of conduct, please use the in-app reporting workflow required by Microsoft Store policy 11.16:

1. In the result popup, select the small **Report inappropriate AI output** button (icon only, next to the Send button).
2. A browser window opens with the `ai-abuse-report` issue template in the [`snap-to-ai-azure`](https://github.com/snap-to-ai/snap-to-ai-azure/issues) repository. The application pre-fills the template with:
  - UTC timestamp, current UI language, and deployment/model name.
  - The latest `instructions.txt` content (truncated to 4,000 characters).
  - The most recent conversation history or single-shot response.
3. Review the auto-collected section carefully. Remove confidential text or redact prompts/screenshots before submitting. Images are **not** attached automatically; drag and drop them into the issue if you need to share them.
4. Check the appropriate category (violence, hate/harassment, sexual content, malware, privacy, or other) and describe what happened.

This flow keeps the audit trail required by Microsoft Store certification while giving you full control over the data that leaves your environment.

## Response Targets
- Support is provided by a solo developer and handled on a best-effort basis.
- The aspirational goal is an initial response within **3 business days** so that enterprise teams can plan their next steps, but replies may take longer during heavy workload periods.
- Complex incidents (e.g., Azure policy conflicts) may require additional follow-up through private channels.

## Privacy & Sensitive Data
Do not upload raw screenshots containing confidential information. Redact or mask sensitive areas before sharing. If you need to provide secure materials, coordinate with us via the contact method listed in [`SECURITY.md`](SECURITY.md).
