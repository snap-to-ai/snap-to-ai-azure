# Snap to AI Support

Snap to AI is a Windows 11 companion that turns a screen selection into an instant AI explanation. This repository collects the user-facing guidance, troubleshooting tips, and support entry points for the Microsoft Store build.

## What you get
- **One-step capture to insight** – drag a rectangle and receive an Azure AI or Azure OpenAI response right away.
- **Conversation-ready popup** – continue the discussion directly inside the overlay without switching windows.
- **Enterprise-friendly setup** – sign in with Microsoft Entra ID, use your own Azure endpoint, and follow documented allowlists when needed.

## Subscription model
- Snap to AI is now a Microsoft Store subscription so we can keep pace with rapidly changing Azure AI / Azure OpenAI APIs and ship compatibility fixes the moment Microsoft updates the platform.
- Your subscription directly funds the monitoring, testing, and documentation work required to keep the capture workflow reliable while those APIs evolve.
- A 30-day free trial is available before the first charge; cancel any time to stop future billing.

## Prepare your Azure environment
Make sure the following items are in place before you install the app:

1. **Provision the resource** – create either an Azure OpenAI resource (`*.openai.azure.com`) or an Azure AI Foundry project (`*.services.ai.azure.com`).
2. **Assign the role** – grant each user (or their Azure AD group) either `Cognitive Services OpenAI User` or `Azure AI User` on the resource, resource group, or subscription.
3. **Create the enterprise application** – have an administrator consent to client ID `6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3` so that “SnapToAIforMicrosoftAzure” appears under **Microsoft Entra ID > Enterprise applications**.
4. **Collect connection values** – keep the endpoint URL, deployment name or model ID, and (for Azure OpenAI) the API version `2024-12-01-preview` or newer.
5. **Optional: review network access** – confirm any outbound firewall rules allow the hosts listed in `docs/network-allowlist.md`.

## Set up in five steps
1. Install the Microsoft Store build once the listing is available.
2. Launch the app; the Settings window stays open until the Azure tab is configured.
3. Sign in with your Microsoft Entra work or school account.
4. Enter the endpoint, deployment/model ID, and API version (if required), then select **Save**.
5. Run **Settings → Azure → Test Connection** and, once successful, start capturing with `Ctrl` + `Shift` + `Space`.

For screenshots and full walkthroughs, see [`docs/quickstart.md`](docs/quickstart.md).

## Documentation
- [`docs/quickstart.md`](docs/quickstart.md): complete installation and onboarding guide.
- [`docs/troubleshooting.md`](docs/troubleshooting.md): common issues and log collection.
- [`docs/data-collection.md`](docs/data-collection.md): end-to-end data flow, telemetry coverage, and support handling.
- [`docs/network-allowlist.md`](docs/network-allowlist.md): outbound host list for restricted networks.
- [`docs/firewall-script.md`](docs/firewall-script.md): sample firewall automation script and usage notes (unsupported, best-effort guidance).

## Support & feedback
Open a GitHub Issue in this repository when you need help:
- **Bug report** – provide steps, screenshots, and logs.
- **Feature request** – propose usability improvements or new scenarios.
- Follow [`SECURITY.md`](SECURITY.md) for security disclosures.

As a solo developer I handle requests on a best-effort basis; a response within **three business days** is the aspirational target so teams can plan, but replies may take longer during busy periods. Follow-up sessions may be scheduled if tenant or subscription checks are required.

## License
The documentation in this repository is distributed under the Snap to AI Proprietary Notice. The full text is available in [`LICENSE`](LICENSE).
