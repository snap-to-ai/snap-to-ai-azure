# Data Collection

Snap to AI for Microsoft Azure is designed for privacy-conscious enterprise scenarios. This document explains what information is stored locally and what may be shared when requesting support.

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
