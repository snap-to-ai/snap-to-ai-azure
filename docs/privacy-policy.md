# Privacy Policy

**Last updated: 2025-11-10**

Snap to AI (the "App") analyzes user-supplied screenshots and chat text using Microsoft Azure AI services. By installing or using the App, you agree to this Privacy Policy.

## 1. Data We Collect and Process
- **Screenshots and chat text**: The App processes only the images and follow-up text that you explicitly submit. Screenshots are converted to Base64 strings in memory immediately before transmission and are sent over HTTPS to the Azure OpenAI or Azure AI Foundry endpoint that you configure. The App does not persist these images or request payloads to disk or share them with third parties.
- **Authentication data**: When you sign in with Entra ID (formerly Azure AD), the App obtains access tokens. Tokens are stored in memory only and are never written to disk.
- **Diagnostic logs**: Logs contain metadata such as timestamps, error codes, and endpoint type. They do not contain image data or model responses.
- **Billing information**: Purchases and management of the monthly subscription are handled by Microsoft Store. The App does not receive or store payment information.

## 2. How We Use the Data
- To deliver AI analysis results that you request
- To provide diagnostics for connection tests and error handling
- To check license status and inform you about trial or subscription renewals

## 3. Storage and Retention
- Base64 strings and request payloads generated for transmission are held in memory only while the result popup is open and are discarded when the window closes.
- Diagnostic logs are stored locally (for example, `C:\\Users\\<User>\\AppData\\Local\\SnapToAIForMicrosoftAzure\\`).
- Entra ID access tokens are discarded when the session ends or you sign out, and they are never persisted.

## 4. Data Sharing
- The App sends data only to the Microsoft Azure services (such as Azure OpenAI or Azure AI Foundry) that you configure. The App does not otherwise store or disclose your data.

## 5. Security Measures
- Application data is stored within the Windows user profile.
- Communication with Azure endpoints is encrypted with TLS.
- The App supports enterprise controls such as FQDN allowlists and proxy configuration.

## 6. Age Requirements
- The App may be used by general, enterprise, and educational users. If the connected Azure AI service imposes age restrictions, you must follow those service terms.

## 7. Your Choices and Rights
- You can adjust the Azure endpoint and instructions from the settings window to control what is sent.
- Signing out from the settings window clears your Entra ID session.

## 8. Updates to This Policy
We may update this policy to reflect service improvements or legal changes. We will announce significant updates in the App or on the distribution page.

## 9. Contact
- General support: https://github.com/snap-to-ai/snap-to-ai-azure/issues
- Security reports: https://msrc.microsoft.com/create-report (please enter "Snap to AI" in the product field)

If you have questions about this policy or our data practices, please create an issue via the support channel above.
