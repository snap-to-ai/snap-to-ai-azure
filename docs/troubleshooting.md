# Troubleshooting

This guide lists common issues and recommended recovery steps.

## Sign-in and Authentication
| Symptom | Resolution |
| --- | --- |
| "Authentication required" banner never clears | Sign out from Settings → Account and sign in again. Ensure the account has `Cognitive Services User` or equivalent role on the Azure resource. |
| Interactive login window fails to open | Confirm system webview is functional. Run `wsreset.exe` and reboot. Corporate devices may need Edge WebView2 runtime. |
| Account question during sign-in | Azure policies (MFA, conditional access) must be satisfied. Check with your administrator. |

## Consent Prompt Warning
| Symptom | Resolution |
| --- | --- |
| Consent screen shows "Publisher: unverified" | Snap to AI for Microsoft Azure is shipped without a Verified Publisher badge. Verification demands owning and maintaining a custom domain and completing Partner Center enrollment, which are out of scope for this individual project. Review the requested permissions and tenant-owned app ID (`6fbd71ff-01dc-4cb0-bc22-40b8f0188ab3`); once confirmed, administrators can safely grant consent. |

## Connection Tests
| Symptom | Resolution |
| --- | --- |
| Test Connection returns HTTP 401/403 | Verify endpoint URL, deployment name, and API version. Ensure the signed-in account is assigned the correct Azure role. |
| HTTP 429 or 503 errors | The Azure resource is throttled. Review Azure metrics and increase capacity or reduce load. |
| Proxy or firewall failures | Confirm required FQDNs are allowlisted (see [network-allowlist.md](network-allowlist.md)): `*.openai.azure.com`, `*.services.ai.azure.com`, `login.microsoftonline.com`, `storeedgefd.dsx.mp.microsoft.com`, and `purchase.mp.microsoft.com`. |

## Capture Workflow
| Symptom | Resolution |
| --- | --- |
| Capture shortcut does nothing | Ensure the app is running (tray icon visible). Check Windows Settings → Privacy & Security → Screen capture for permission. |
| Popup appears empty | Verify AI response succeeded in the log. If the model returns an empty response, try re-running with different instructions. |
| High DPI misalignment | Make sure Windows display scaling is set per monitor; restart the app after changing scaling. |

## Logs and Diagnostics
1. Open `%LocalAppData%\SnapToAIForMicrosoftAzure\SnapToAIForMicrosoftAzure.log`.
2. Copy relevant lines (remove credentials or personal data before sharing).
3. Attach excerpts to your GitHub Issue or provide via a secure channel if requested.

## Contacting Support
If these steps do not resolve the problem, open a [bug report](../.github/ISSUE_TEMPLATE/bug-report.yml) with detailed reproduction steps, or consult [Support](../SUPPORT.md) for escalation guidance.
