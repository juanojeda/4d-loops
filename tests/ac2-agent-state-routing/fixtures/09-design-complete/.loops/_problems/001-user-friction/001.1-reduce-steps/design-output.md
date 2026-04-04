# Design Output: 001.1 — Reduce steps to activation

**Status:** complete
**Loop:** 2 — Design Sprint
**Last updated:** 2026-04-06

---

## 1. Chosen concept and reasoning

Defer billing to post-activation. Users complete a minimal setup (name, email, team size) and land in the product before being asked for billing details. Billing is prompted on day 3 or at first value moment.

---

## 2. Rejected directions

- **Simplify billing form (keep upfront):** Addressed the wrong problem — friction is psychological (distrust before value), not form length. Revisit if deferred billing creates abuse issues.
- **Skip billing entirely for trial:** Increases trial abuse risk unacceptably for enterprise tier. Revisit for SMB tier.

---

## 3. Validation evidence and confidence level

4 prototype sessions, April 2026. All 4 users completed setup without hesitation. 3/4 noted they preferred being in the product first. Confidence: high.

---

## 4. Hard constraints

- Trial capped at 14 days; billing required before day 14
- Billing must be collected before first invoice date
- Day 3 prompt is a hard requirement for compliance

---

## 5. Open questions

- [x] What happens if user doesn't add billing by day 3? → Account moves to read-only. Billing prompt shown on every login. Resolved 2026-04-05.
- [x] Does "first value moment" need per-persona definition? → Deferred to Loop 3; not a blocker.

---

## 6. Technical notes

Requires: auth flow changes, onboarding wizard, billing prompt scheduling service.

---

## 7. Design decisions log

| Decision | Chosen | Rejected | Rationale |
|---|---|---|---|
| Billing timing | Defer to day 3 | Require upfront | Users won't pay before seeing value |
| Day 3 action | Read-only lockout | Soft prompt only | Compliance requirement |

---

## 8. Feedback instrumentation requirements

- `[FEEDBACK] Track: onboarding completion rate (baseline vs. post-ship)`
- `[FEEDBACK] Track: time-to-activation (first meaningful action)`
- `[FEEDBACK] Track: billing conversion rate at day 3 prompt`
- `[FEEDBACK] Alert: if trial abuse rate exceeds 5% of completions`
