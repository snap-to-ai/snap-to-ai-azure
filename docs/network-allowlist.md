# Network Allowlist

Allow outbound HTTPS (TCP 443) to these hosts when your environment enforces firewall or proxy rules. Environments without outbound restrictions can ignore this list.

- `*.openai.azure.com` – Azure OpenAI resource endpoints
- `*.services.ai.azure.com` – Azure AI Foundry (Azure AI Inference) endpoints
- `login.microsoftonline.com`
- `login.windows.net`
- `login.live.com`
- `logincdn.msauth.net`
- `aadcdn.msftauth.net`
- `localhost` (loopback redirect used during interactive sign-in)
- `displaycatalog.mp.microsoft.com`
- `purchase.mp.microsoft.com`
- `licensing.mp.microsoft.com`
- `storeedgefd.dsx.mp.microsoft.com`
