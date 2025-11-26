# Security Policy

## Supported Versions
Security fixes are provided for the current Microsoft Store release of Snap to AI. Older sidelines or developer-preview builds are not covered.

## Reporting a Vulnerability
We support both public and private channels. Choose the option that matches the sensitivity of your report.

### GitHub Issue (default)
1. Open a new Issue using the "Report a security vulnerability" template.
2. Share a clear description, impact, and sanitized reproduction steps. **Do not include secrets, tenant identifiers, or customer data.**
3. Monitor the Issue for follow-up questions. Responses are best-effort and handled by a solo maintainer; the target is to reply within 3 business days, but complex schedules may cause delays.
4. If you must provide unredacted evidence, keep the Issue open for tracking but email the sensitive attachment to `snaptoai.helpdesk@gmail.com` using the Issue number in the subject (e.g., `[#123] Confidential crash dump`).

### Microsoft Security Response Center (MSRC)
If sensitive information (e.g., exploit code, customer data, or unpublished infrastructure details) is required, submit the report privately through the [MSRC portal](https://msrc.microsoft.com/create-report) and include "Snap to AI" in the product field. You may optionally reference the GitHub Issue number for easier coordination.
After the MSRC submission is filed, you may also use `snaptoai.helpdesk@gmail.com` to share any follow-up files that cannot be posted in the portal UI, again referencing the Issue or MSRC tracking ID in the subject line.

When contacting us via either channel, please include:
- A description of the vulnerability and potential impact.
- Steps to reproduce or proof-of-concept code (sanitized if public).
- Any temporary mitigations you have identified.

We coordinate disclosure timelines following MSRC guidance and recognize reporters at our discretion after a fix ships.
