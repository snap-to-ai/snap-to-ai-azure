# Quickstart

This guide walks new users through installing Snap to AI for Microsoft Azure and completing the initial configuration.

## 1. Install the App
- Open the Microsoft Store on Windows 11 and search for **"Snap to AI for Microsoft Azure"**.
- Confirm the publisher and click **Get** to install.
- Launch the app from the Start menu.

## 2. Sign In with Microsoft Entra ID
- On first launch you will be prompted to sign in.
- Use your work or school account that has access to the Azure subscription hosting your AI resource.
- Grant the requested permissions. Tokens are cached locally and never stored on our servers.

## 3. Configure Azure Endpoint
1. Open the Settings window from the tray icon or by pressing `Ctrl` + `,` while the popup is active.
2. Provide the Azure resource details:
   - **Endpoint**: The base URL of your Azure OpenAI or Azure AI Foundry deployment.
   - **Deployment name / Model ID**: The deployment identifier configured in Azure.
   - **API version** (Azure OpenAI only): e.g. `2024-08-01-preview`.
3. Save changes. The app validates the configuration before resuming background capture.

## 4. Test the Connection
- In Settings → Azure, select **Test Connection**.
- The app sends a small white image and expects the response `true`.
- Success confirms authentication, networking, and deployment wiring.

## 5. Capture and Interpret
- Press `Ctrl` + `Shift` + `Space` to start capture mode.
- Drag a rectangle over the area of interest. Release to trigger inference.
- The popup displays the AI interpretation, with buttons for **Copy**, **Refresh**, and **Ask follow-up**.

## 6. Optional Configuration
- **Theme**: Switch between light/dark popup styles in Settings → General.
- **Language**: Choose UI language (English, Japanese, Chinese (Simplified/Traditional), Korean, Thai, Vietnamese, Russian, Turkish, Portuguese).
- **Instructions**: Modify prompt instructions via `instructions.txt` to tailor responses.

## Next Steps
- Review [Troubleshooting](troubleshooting.md) for connectivity or sign-in issues.
- Learn what diagnostic information is stored in [Data Collection](data-collection.md).
