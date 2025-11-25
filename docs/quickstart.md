# Quickstart

This guide walks new users through installing Snap to AI and completing the initial configuration.

## 1. Prepare Azure (complete before installation)

1. **Create or identify your AI resource**
   - Azure portal → search for *Azure OpenAI* or *AI Services*.
   - Azure OpenAI endpoints end with `openai.azure.com` (for example `https://contoso.openai.azure.com/`).
   - Azure AI Foundry projects use endpoints such as `https://contoso.services.ai.azure.com/`. When they host Azure OpenAI deployments, the deployment itself still uses the `*.openai.azure.com` endpoint; the exact format may change as the platform evolves.

2. **Grant resource access to every user**
   - Azure portal → open the resource (or its resource group / subscription) → **Access control (IAM)** → **Add** → **Add role assignment**.
   - Select one of the following roles and assign the user or group that will run the app:
     - `Cognitive Services OpenAI User` for Azure OpenAI.
     - `Azure AI User` for Azure AI Foundry.
   - The assignment may take a few minutes to propagate.

3. **Create the enterprise application instance and grant consent**
    - Because the app is not listed in the Microsoft gallery, use one of these administrator actions:
       - Open `https://login.microsoftonline.com/<tenantId>/adminconsent?client_id=6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3&redirect_uri=http://localhost`, review the requested permissions, and approve (recommended).
       - Or execute an administrative command such as `az ad sp create --id 6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3` (Azure CLI) / `New-MgServicePrincipal -AppId 6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3` (Microsoft Graph PowerShell) to create the service principal, then grant admin consent in the portal.
   - After consent or command execution completes, the enterprise app named “SnapToAIforMicrosoftAzure” appears under **Microsoft Entra ID > Enterprise applications**. Assign users or groups there if you require scoped access.

4. **Collect connection settings for the app**
   - **Endpoint**:
     - Azure OpenAI example: `https://contoso.openai.azure.com/`
     - Azure AI Foundry example: `https://contoso.services.ai.azure.com/`
   - **Deployment name / Model ID**: the exact deployment identifier configured in your resource.
   - **API version**: required only for Azure OpenAI. Use `2024-12-01-preview` or a newer supported preview. Leave blank for Azure AI Foundry.

5. **(Optional) Update network allowlists**
   - If outbound traffic is filtered, permit the hosts documented in `network-allowlist.md`.

## 2. Install the App
- Open the Microsoft Store on Windows 11 and search for **"Snap to AI"**.
- Confirm the publisher and click **Get** to install.
- Launch the app from the Start menu. The Settings window opens automatically when Azure settings are incomplete.

## 3. Sign In with Microsoft Entra ID
- The app uses interactive MSAL authentication if no cached token is available.
- Sign in with the work or school account that received the role assignment in step 1.
- If you see “admin approval required,” repeat the consent flow in step 1.3.

## 4. Configure Azure Settings
1. In the Settings window, open the **Azure** tab.
2. Enter the Endpoint, Deployment name / Model ID, and (for Azure OpenAI) API version collected earlier.
3. Select **Save**. The values are written to `%AppData%\SnapToAIForMicrosoftAzure\.env` and applied immediately.

## 5. Test the Connection
- In Settings → **Azure**, click **Test Connection**.
- The app sends a 100×100 white PNG with instructions; a response of `true` confirms consent, role assignment, and network reachability.
- Any other response (including `[Error]` prefixes) is logged to `%LocalAppData%\SnapToAIForMicrosoftAzure\SnapToAIForMicrosoftAzure.log` for troubleshooting.

## 6. Capture and Interpret Screenshots
- Press `Ctrl` + `Shift` + `Space` to start capture mode (default keyboard trigger). Optional mouse modifiers can be configured in Settings → **General**.
- Drag a rectangle over the area to analyze and release the mouse button. Zero-area selections captured via keyboard `Enter` run the word-lookup instruction around the cursor.
- The popup shows the AI interpretation and supports **Copy**, **Refresh**, and follow-up prompts inline.

## 7. Optional Configuration
- **Theme**: Switch between light/dark in Settings → **General**.
- **Language**: Choose from English, Japanese, Simplified/Traditional Chinese, Korean, Thai, Vietnamese, Russian, Turkish, and Portuguese.
- **Instructions**: Edit `instructions.txt` from Settings → **General** to customize the system prompt.

## Next Steps
- Review [Troubleshooting](troubleshooting.md) if connection tests fail or authentication prompts repeat.
- Learn what diagnostic information is stored in [Data Collection](data-collection.md).
