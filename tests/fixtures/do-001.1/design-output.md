# Design Output
**ID:** DO-001
**Status:** approved
**Version:** 1.1
**Created:** 2026-04-28
**Author:** Juan Ojeda
**Source Discovery Output:** —
**Source Decision Log entries:** DL-001, DL-002, DL-003, DL-004, DL-005, DL-006
**Sprint ref:** Sprint-001
**Approved by:** Juan Ojeda
**Approval date:** 2026-05-05

> ⚠️ **UNVALIDATED** — this output is based on an unvalidated problem assumption. See Risk log entry DL-001. Core claim — "no low-friction private sharing channel exists" — has not been confirmed by external users. Treat all problem-level claims as hypotheses, not facts.

---

## 1. Concept summary

A personal moments-sharing system for Juan to privately share photos and brief notes with specific recipient groups (family, close friends) via a weekly email digest. Juan submits moments by sending a photo and optional caption to a Telegram bot on his phone. The bot queues submissions and, on a weekly schedule, prompts Juan to approve the digest before it is sent. Recipients receive a plain-HTML email with inline photos and captions. No content is stored on public-facing infrastructure.

---

## 2. User and context

**Confidence:** assumed  
**Evidence ref:** assumed — no external interviews conducted

| Field | Detail |
|---|---|
| **Who** | Juan Ojeda — solo operator; technically comfortable; primary content creator |
| **Situation** | Has photos on mobile he wants to share with family or friends; does not want to post to public social media |
| **Device / platform** | Mobile (iOS) as primary submission device; desktop for any config changes |
| **Prior context** | Has Telegram installed; maintains a mental list of family members and close friends who want to stay in touch |
| **Goal** | Share personal moments with specific private groups without friction, and without exposure to unintended audiences |
| **Current friction** | Public social media = wrong audience and privacy risk; WhatsApp = no separation between recipient groups; manual email = high curation effort; no existing tool covers private multi-recipient digest with low mobile friction |

---

## 3. Decision Frame

**Problem we're solving:**  
Juan has no low-friction, private channel to share personal moments with specific recipient groups — existing tools are either too public, too manual, or don't support group separation.

**Success looks like:**  
Juan submits at least one moment per week for four consecutive weeks. At least one recipient replies to a digest within the first three sends.

**Hard constraints:**
- Submitted content must not be stored on public-facing infrastructure
- Submission must take no more than 30 seconds from photo to queued
- System must work from Juan's existing mobile setup (no new app install required for submission)

**Soft constraints:**
- Mobile-first interaction for submission
- Minimal config overhead (one-time setup; no ongoing management UI needed)
- Weekly cadence as default; skippable if Juan is away

**What we're explicitly not solving here:**
- Multi-user mode (other people submitting moments) — out of scope for v1
- Two-way conversation threads between recipients — out of scope; digest is one-directional
- SMS or non-email delivery — out of scope; email is sufficient for target recipients

---

## 4. Chosen concept

**Concept name:** Telegram bot + email digest  
**Confidence in this direction:** medium

### Description
Juan sends a photo (and optional caption) to a dedicated Telegram bot. The bot queues the moment. On a weekly schedule the bot prompts Juan via Telegram to review the queued moments and approve or postpone the send. On approval, the system compiles a plain-HTML email digest and delivers it to configured recipient groups.

### Key interaction or flow
1. Juan opens Telegram, sends photo + optional caption to his bot
2. Bot replies: "Moment queued. You have N moments queued for this week."
3. Each Sunday evening, bot sends: "You have N moments queued. Send digest now, or postpone to next week?"
4. Juan replies: "Send" or "Postpone"
5. On "Send": system compiles digest email, sends to all recipient groups in config
6. Recipients receive plain-HTML email with subject "Moments from Juan — week of {date}"

### Why this concept
Telegram is already installed on Juan's phone; submission is three taps. Bot-mediated approval step keeps Juan in control of timing and prevents accidental sends. Email delivery reaches family members regardless of their own app preferences.

---

## 5. Key decisions

### Decision 1 — Telegram bot as submission mechanism
**DL ref:** DL-001  
**Decision:** Submission via Telegram bot, not WhatsApp, web form, or native app.  
**Rationale:** Telegram bot takes 5 minutes to set up (BotFather), is free, reliable, and internationally available. WhatsApp Business API requires approval, phone verification, and cost. Web form adds browser-open friction. Native app exceeds build budget for v1.  
**Impact on spec:** Spec must include Telegram Bot API integration. No web submission UI needed.

### Decision 2 — Config via YAML file
**DL ref:** DL-002  
**Decision:** Recipient groups and system settings managed via a YAML config file; no Telegram command interface or admin UI.  
**Rationale:** Juan is technically comfortable. Config file is simpler to build and version-control than a command interface. No ongoing management UI needed.  
**Impact on spec:** Spec must define YAML schema for recipient groups, cadence, and digest settings.

### Decision 3 — Bot-mediated publish flow
**DL ref:** DL-003  
**Decision:** Bot prompts Juan weekly and waits for explicit approval before sending. Minimum 1 queued moment required to trigger send prompt.  
**Rationale:** Prevents accidental sends; keeps Juan in control of timing.  
**Impact on spec:** Spec must include approval flow state machine. Bot must not send without explicit confirmation.

### Decision 4 — Unlisted URL for any web component
**DL ref:** DL-004  
**Decision:** Any web-accessible component uses an unguessable slug (unlisted URL), not a public or indexed URL.  
**Rationale:** Satisfies "content not on public-facing infrastructure" constraint without requiring auth. Practical for v1; can be upgraded to auth in v2 if needed. This is a conscious relaxation of the hard constraint — noted as acceptable for v1.  
**Impact on spec:** Spec must not generate publicly indexed URLs. Slugs must be cryptographically random.

### Decision 5 — Weekly cadence, minimum 1 moment
**DL ref:** DL-005  
**Decision:** Default cadence is weekly (Sunday evening). Send threshold is ≥1 queued moment.  
**Rationale:** Matches Juan's natural sharing rhythm. Low threshold prevents weeks of silence when activity is low.  
**Impact on spec:** Scheduler runs weekly. If queue is empty on trigger, bot notifies Juan but does not send.

### Decision 6 — Plain HTML email
**DL ref:** DL-006  
**Decision:** Digest email is plain HTML (inline images, minimal styling). No rich template framework.  
**Rationale:** Reduces deliverability risk. Simpler to build and maintain. Sufficient for family recipients.  
**Impact on spec:** Email template must not use external CSS frameworks or tracked pixels.

---

## 6. Rejected directions

| Concept | Why it was rejected | Conditions to revisit |
|---|---|---|
| WhatsApp bot | Meta Business API requires approval, phone verification, and cost. Unofficial libs violate ToS and break unpredictably. Does not meet 30-sec setup constraint. | If a stable, ToS-compliant, low-cost WhatsApp API becomes available and Juan switches primary messaging app. |
| Web form submission | Opening a browser adds friction beyond the 30-sec constraint for mobile submission. Login or link management adds overhead. | If Telegram proves unreliable or Juan's recipient base needs a non-bot submission option. |
| Native mobile app (iOS/Android) | Build cost disproportionate to v1 scope. Requires App Store approval for distribution. | If v1 proves the concept and Juan wants a polished submission UX. |
| Public blog | Drops the privacy hard constraint entirely. Requires conscious decision to revise the problem frame. | If Juan decides public sharing is acceptable and rewrites the problem statement. |
| Styled HTML email (template framework) | External CSS frameworks increase deliverability risk and add build overhead not justified by v1 needs. | If recipient feedback indicates layout matters, or if a deliverability audit recommends it. |

---

## 7. Validation evidence

**Testing method:** not tested  
**Participants:** synthetic persona review only (no real users)  
**When:** Sprint-001, week 1  
**Stimulus used:** description only

### What we tested
Reviewed submission flow against 30-sec constraint using synthetic persona. Estimated tap count for Telegram submission: open Telegram → select bot → send photo → add caption → send = 4–6 taps, ~15 seconds. Within constraint.

### What we learned
No real user testing conducted. Synthetic review did not surface blocking usability issues in the submission flow. Approval flow (Sunday prompt) was not tested — behaviour under edge cases (no queued moments, Juan ignores prompt) is unverified.

### How this changed the concept
No changes from testing. Concept unchanged from initial design.

### Remaining uncertainty
- Whether Telegram friction is low enough to form a habit (no real data)
- Whether email digest format will drive replies from family recipients (untested)
- Behaviour when approval prompt is missed or ignored

**Overall confidence in concept:** medium  
**If medium or low:** Confidence increases after first 3–4 sends with measurable reply signal.

---

## 8. Constraints for the spec

**Technical constraints:**
- Must use Telegram Bot API for submission and approval flow
- Email delivery via SMTP or transactional email service (e.g. SendGrid, Postmark)
- Config stored as YAML file; no database required for v1
- Submitted content (photos) must not be stored on public-facing infrastructure; storage must be local or private cloud
- Unlisted URL slugs must use cryptographically random values (≥128 bits entropy)

**Design / UX constraints:**
- Submission flow must complete in ≤30 seconds on mobile
- No new app install required for Juan to submit moments
- Approval prompt must be sent via Telegram (same channel as submission)

**Business / compliance constraints:**
- No PII stored beyond email addresses in config file
- No publicly indexed URLs for any content
- No external tracking pixels in email

**Platform constraints:**
- Juan's submission device: iOS mobile
- Recipient delivery: email (all major clients)

**Feedback instrumentation requirements** *(required — spec is incomplete without this)*

The following signals must be capturable after ship for the feedback loop to close. For each, the spec must include a `[FEEDBACK]` acceptance criterion.

| Signal name | What it measures | Links to outcome metric | Minimum fidelity |
|---|---|---|---|
| moment_submitted | Juan's submission behaviour — frequency and consistency | Moments submitted per week | Event fires on each successful bot receipt of photo |
| digest_sent | Digest delivery — whether the system is actually sending | Digests sent per month | Event fires on each successful email dispatch |
| reply_received | Recipient engagement — whether anyone responds | Reply rate per digest | Email reply detection (parse reply-to) or manual log entry via bot command |
| unsubscribe_event | Recipient retention — whether recipients opt out | Recipient retention rate | Event fires when recipient requests removal (via reply keyword or config update) |

---

## 9. Open questions

All questions resolved prior to approval.

| # | Question | Owner | Required by |
|---|---|---|---|
| 1 | Which submission mechanism? Telegram, WhatsApp, web form, or app? | Juan | Sprint-001 week 1 |
| 2 | How are recipient groups managed? Config file or bot commands? | Juan | Sprint-001 week 1 |
| 3 | What is the digest format? Plain or styled HTML? | Juan | Sprint-001 week 1 |
| 4 | Default cadence and skip behaviour? | Juan | Sprint-001 week 1 |
| 5 | Minimum moment threshold to trigger send? | Juan | Sprint-001 week 1 |

---

## 10. Assumptions carried forward

| # | Assumption | Confidence | What would change it |
|---|---|---|---|
| 1 | Telegram is low-friction enough for Juan to form a weekly submission habit | low | Using the system for 4+ consecutive weeks with ≥1 submission/week |
| 2 | Recipients engage with email digests and don't treat them as spam | medium | First 3 sends with at least 1 reply signal |
| 3 | Weekly cadence matches Juan's natural rhythm | medium | Baseline send data after first month |
| 4 | YAML config is sufficient for recipient management without a UI | high | Juan requests a management interface after using v1 |
| 5 | Unlisted URL approach satisfies privacy constraint adequately for v1 | medium | Security review or Juan explicitly decides public is unacceptable |
| 6 | Email is the right delivery channel for all recipient groups | medium | Recipient feedback indicating preference for another channel |

---

## 11. Deferred opportunities

- **Multi-user mode:** Other family members submit moments to a shared digest. Deferred — adds auth complexity not justified for v1.
- **Photo gallery web view:** Recipients can browse past digests via a private web page. Deferred — adds storage and web serving complexity.
- **SMS fallback:** Delivery to recipients who don't use email. Deferred — adds cost and complexity; all current recipients have email.
- **Telegram command interface for config:** `/addrecipient`, `/removerecipient` etc. Deferred — YAML is sufficient for v1.
- **Read receipts / open tracking:** Knowing whether recipients opened the email. Deferred — conflicts with no-tracking-pixel constraint; revisit in v2.

---

## 12. Review triggers

**After 3 sends:**
- Check reply rate. If 0 replies across 3 sends, investigate: is email landing in spam? Are recipients seeing it? Is format engaging?
- Check submission frequency. If Juan submits <1 moment/week on average, investigate habit friction.

**After 8 weeks:**
- Reassess weekly cadence. If Juan frequently postpones, consider fortnightly default.
- Reassess YAML config. If Juan has needed to change recipients and found it cumbersome, consider bot command interface.

**Refutation signals:**
- 0 replies after 3 sends → email channel may be wrong or format not engaging
- Juan stops submitting after week 3 → Telegram friction is higher than expected
- Recipient complaints about spam → deliverability or frequency issue

**Hypothesis eval (DL-001 — core problem):**
- Confirmed if: Juan uses system for 4+ weeks AND at least 1 external person independently describes the same friction without prompting
- Refuted if: Juan abandons the system within 4 weeks and attributes it to "didn't need it" rather than execution friction

---

## AI agent guidance

When consuming this Design Output:

- **Section 5 (Key decisions)** defines what has already been decided. Do not revisit these without a new Decision Log entry.
- **Section 6 (Rejected directions)** defines what is out of scope. Do not propose these approaches unless the conditions to revisit have been met.
- **Section 8 (Constraints)** contains non-negotiable boundaries. Flag any spec requirement that would violate these before proceeding. The feedback instrumentation requirements in Section 8 must each produce at least one `[FEEDBACK]` acceptance criterion in the spec — if any are missing, the spec is incomplete.
- **Section 9 (Open questions)** are all resolved — see Decision Log entries DL-001 through DL-006 for resolutions.
- **Section 10 (Assumptions)** lists claims that are not fully validated. Carry these forward as typed assumptions in the spec — do not treat them as facts.
- This brief carries an **UNVALIDATED** flag. Treat all problem-level claims in Section 2 as hypotheses. The solution direction may be sound; the problem framing may not be.
