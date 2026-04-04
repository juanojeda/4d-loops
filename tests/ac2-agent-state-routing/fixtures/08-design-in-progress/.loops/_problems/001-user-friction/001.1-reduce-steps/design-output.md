# Design Output: 001.1 — Reduce steps to activation

**Status:** in-progress
**Loop:** 2 — Design Sprint
**Last updated:** 2026-04-05

---

## 1. Chosen concept and reasoning

Defer billing to post-activation. Users complete a minimal setup (name, email, team size) and land in the product before being asked for billing details. Billing is prompted on day 3 or at first value moment (whichever comes first).

Chosen because: directly removes the friction point users cited; low technical risk; reversible if it drives trial abuse.

---

## 2. Rejected directions

[INCOMPLETE — document the directions considered and why they were rejected]

---

## 3. Validation evidence and confidence level

Concept validated via 4 prototype sessions, April 2026. All 4 users completed setup without hesitation. Confidence: high.

---

## 4. Hard constraints

- Must not allow unbounded free access — trial limits enforced at day 3
- Billing must be collected before first invoice date

---

## 5. Open questions

- [ ] What happens if user doesn't add billing by day 3? (blocking — needs resolution before spec)
- [ ] Does "first value moment" need to be defined per-persona? (deferred — not blocking)

---

## 6. Technical notes

Requires changes to: auth flow, onboarding wizard, billing prompt scheduling.

---

## 7. Design decisions log

| Decision | Chosen | Rejected | Rationale |
|---|---|---|---|
| Billing timing | Defer to day 3 | Require upfront | Users won't pay before seeing value |

---

## 8. Feedback instrumentation requirements

[INCOMPLETE — define what signals must fire to confirm this change worked]
