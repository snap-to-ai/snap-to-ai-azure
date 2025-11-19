# Data Collection

Snap to AI for Microsoft Azure is designed for privacy-conscious enterprise scenarios. This document explains what information is stored locally and what may be shared when requesting support.

## End-to-End Data Flow

```mermaid
flowchart LR
	User((Screen capture & prompt)) -->|1. Select area, enter text| App[Snap to AI desktop client]
	App -->|2. Persist logs & settings| Local[(Local-only storage)]
	App -->|3. HTTPS call (image + prompt)| Azure[(Your Azure OpenAI / Azure AI Foundry)]
	Azure -->|4. AI response| App
	App -->|5. Optional sanitized evidence| Support[(Enterprise support channel)]
```

1. **Capture** – the user draws a rectangle and optionally types additional instructions. The pixels stay in memory until the inference request finishes.
2. **Local handling** – configuration files (`.env`, `instructions.txt`) and operational logs are written under the user profile as described below; screenshot pixels are never stored.
3. **Outbound request** – the app sends the cropped image, prompt text, and authentication tokens directly to the customer-managed Azure endpoint over HTTPS.
4. **Response display** – Azure returns the model output, which is rendered inside the popup and not written to disk unless the user copies it elsewhere.
5. **Support sharing (optional)** – when pursuing a support ticket, administrators may export log snippets or redacted screenshots; these artifacts flow only through the channel agreed with the customer.

## Local Storage
- `%LocalAppData%\SnapToAIForMicrosoftAzure\SnapToAIForMicrosoftAzure.log`: operational log containing timestamps, DPI settings, capture triggers, Azure request metadata (endpoint type, latency), and error messages. Screenshot content is **never** stored.
- `%AppData%\SnapToAIForMicrosoftAzure\.env`: configuration values such as endpoint URL, deployment name, and theme preference.
- `%AppData%\SnapToAIForMicrosoftAzure\instructions.txt`: optional custom instructions used during inference.

## Data Sent to Azure
- Image crops captured by the user are transmitted to the configured Azure AI endpoint.
- Prompt text and follow-up questions are included in the same requests.
- Authentication tokens generated via Microsoft Entra ID are passed to Azure and not stored on our servers.

## Telemetry
- The Microsoft Store build does **not** transmit telemetry to Snap to AI-operated services.
- Windows may collect standard Store diagnostics per your OS settings.

## Sharing Information with Support
When opening a bug report, you may be asked to provide:
- Sanitised log excerpts.
- Redacted screenshots demonstrating UI behaviour.
- High-level Azure resource identifiers (subscription name, region). Avoid sharing subscription IDs, keys, or secrets.

If sensitive material must be shared, coordinate through the secure channel described in [`SECURITY.md`](../SECURITY.md).
