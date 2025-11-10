# Snap to AI for Microsoft Azure Support

Snap to AI for Microsoft Azure delivers an instant screenshot interpretation experience on Windows 11. This public repository hosts user-facing documentation, issue templates, and the discussion channel for the Microsoft Store build of the app. All product code stays in a private repository and is synchronized here via automation.

## Highlights
- **One-step capture to insight**: draw a rectangle, receive an Azure AI or Azure OpenAI response instantly.
- **Conversation-ready popup**: follow up with additional prompts without leaving the overlay.
- **Enterprise-ready**: Entra ID sign-in, bring-your-own Azure endpoint, and documented network allowlists.

## Before You Install
You need the following Azure prerequisites before the Microsoft Store build can analyze screenshots:

1. **Azure resource is ready** – provision either an Azure OpenAI resource (`*.openai.azure.com`) or an Azure AI Foundry project (`*.services.ai.azure.com`).
2. **Role assignment for every user** – in the Azure portal, open the resource (or its resource group/subscription) → **Access control (IAM)** → **Add role assignment** → grant:
	- `Cognitive Services OpenAI User` for Azure OpenAI, or
	- `Azure AI Developer` (preferred) / `Cognitive Services OpenAI User` for Azure AI Foundry.
	Assign the individual user or a group that contains the user who will run the app.
3. **Create the enterprise app instance** – an administrator must create the service principal for client ID `6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3`. Because this app is not listed in the Microsoft gallery, the supported options are:
	- Open `https://login.microsoftonline.com/<tenantId>/adminconsent?client_id=6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3&redirect_uri=http://localhost` and approve the requested permissions (recommended).
	- Or run an administrative command such as `az ad sp create --id 6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3` (Azure CLI) / `New-MgServicePrincipal -AppId 6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3` (Microsoft Graph PowerShell) to create the service principal, then grant admin consent in the portal.
		After the service principal exists, the enterprise application named “SnapToAIforMicrosoftAzure” appears under **Microsoft Entra ID > Enterprise applications**, where you can scope assignments if required.
4. **Collect connection values** – the Settings window requires:
	- **Endpoint**: the full resource endpoint, for example `https://contoso.openai.azure.com/` (Azure OpenAI) or `https://contoso.services.ai.azure.com/` (Azure AI Foundry hosting may still surface `*.openai.azure.com`; formats can evolve).
	- **Deployment name / Model ID**: the deployment identifier configured in Azure. Foundry uses the model ID.
	- **API version**: only for Azure OpenAI. Use `2024-12-01-preview` or newer; older versions are rejected by the app.
	Keep these values handy for first launch.
5. **Optional: allowlist network endpoints** – if your environment restricts outbound traffic, ensure the hosts documented in `docs/network-allowlist.md` are reachable.

## Getting Started
1. Install the app from the Microsoft Store (listing link will be published at launch).
2. Launch the app. The Settings window opens automatically until Azure settings are saved.
3. Sign in with your Microsoft Entra work or school account. Interactive sign-in launches if a silent token cannot be retrieved.
4. Enter the endpoint, deployment, and (if applicable) API version you collected earlier, then choose **Save**.
5. In **Settings → Azure**, select **Test Connection**. The test sends a white 100×100 PNG; a `true` response confirms role, consent, and network configuration.
6. Close Settings. Trigger a capture with `Ctrl` + `Shift` + `Space`, drag a rectangle, and review the AI-generated interpretation. Use **Copy**, **Refresh**, or type follow-up prompts inside the popup.

More detailed guidance is available under [`docs/`](docs/).

## Documentation
- [`docs/quickstart.md`](docs/quickstart.md): full installation, Azure preparation, and onboarding checklist.
- [`docs/troubleshooting.md`](docs/troubleshooting.md): common errors and how to capture logs.
- [`docs/data-collection.md`](docs/data-collection.md): what telemetry we store and how support handles log files.
- [`docs/network-allowlist.md`](docs/network-allowlist.md): outbound firewall exceptions to allow.

## Support & Feedback
Please use GitHub Issues in this repository for public support requests:
- Choose **Bug report** for defects and include reproduction steps, screenshots, and logs.
- Choose **Feature request** for improvement ideas or usability feedback.
- Security-sensitive reports should follow the instructions in [`SECURITY.md`](SECURITY.md).

We aim to respond within three business days. Responses may require scheduling follow-up sessions if subscription/tenant configuration checks are needed.

## Repository Structure & Automation
This repository is synchronized from the private development repository under the `docs/public/repo/` directory. Changes originate there, undergo internal review, and are published here by GitHub Actions (`.github/workflows/sync-public.yml`). Direct pull requests are welcome but may be merged via the private repo to maintain a single source of truth.

## License
The documentation in this repository is provided under the same license as the application. See [`LICENSE`](LICENSE) for details.
