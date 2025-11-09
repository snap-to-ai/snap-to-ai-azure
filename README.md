# Snap to AI for Microsoft Azure Support

Snap to AI for Microsoft Azure delivers an instant screenshot interpretation experience on Windows 11. This public repository hosts user-facing documentation, issue templates, and the discussion channel for the Microsoft Store build of the app. All product code stays in a private repository and is synchronized here via automation.

## Highlights
- **One-step capture to insight**: draw a rectangle, receive an Azure AI or Azure OpenAI response instantly.
- **Conversation-ready popup**: follow up with additional prompts without leaving the overlay.
- **Enterprise-ready**: Entra ID sign-in, bring-your-own Azure endpoint, and documented network allowlists.

## Getting Started
1. Install the app from the Microsoft Store (listing link will be published at launch).
2. Sign in with your work or school account (Microsoft Entra ID).
3. Configure your Azure OpenAI or Azure AI Foundry endpoint in the Settings window.
4. Trigger a capture (`Ctrl` + `Shift` + `Space`) and review the AI-generated interpretation.

More detailed guidance is available under [`docs/`](docs/).

## Documentation
- [`docs/quickstart.md`](docs/quickstart.md): installation flow and first-time setup checklist.
- [`docs/troubleshooting.md`](docs/troubleshooting.md): common errors and how to capture logs.
- [`docs/data-collection.md`](docs/data-collection.md): what telemetry we store and how support handles log files.

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
