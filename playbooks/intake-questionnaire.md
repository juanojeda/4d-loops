# 4D Loops — Intake Questionnaire

Use this whenever you pick up work and aren't sure where you are or where to start. Work through the questions in order — each one either routes you somewhere or moves you to the next question.

---

## Q1. Do you have something already in `.loops/`?

- **Yes** → check `_index.md`. Find the relevant entry and go to Q2.
- **No** → go to Q3.

---

## Q2. What is the status of the most recent artefact in that folder?

- **Discovery output — draft or in progress** → you're mid-framing. Go to Q6.
- **Discovery output — complete, unvalidated** → you've taken a conscious risk. Check the risk log entry for the validation checkpoint. If the checkpoint has been reached, go to Q6. If not, go to Q9.
- **Discovery output — complete, validated** → go to Q9.
- **Design output — in progress** → you're mid-sprint. Go to Q10.
- **Design output — complete** → go to Q12.
- **Implementation folder exists** → check your SDD tooling for build status. If shipped, go to Q14. If in progress, continue in Loop 3.
- **Not sure** → read the most recent file in the folder and the last Decision Log entry referencing this problem. Then come back and answer Q2 again.

---

## Q3. Do you have a solution or feature you want to build?

- **Yes** → what problem does it assume exists? Write it in one sentence. If you can't, go to Q4 and treat it as a hunch. If you can, note it and go to Q4 — your solution will be treated as a candidate direction, not a given.
- **No** → go to Q4.

---

## Q4. Has anyone outside your team confirmed there is a real problem here?

By confirmed — they said it unprompted, analytics show a supporting behaviour, or multiple people independently described the same friction. Your own intuition doesn't count, even if it's strong.

- **Yes** → go to Q5.
- **No** → you have a hunch. Add it to `_discovery/_questions/` as a research question. Come back when something external confirms it. **Stop here.**

---

## Q5. What do you have?

- **One or a few observations** — a quote, an analytics anomaly, a support complaint → add to `_discovery/_data/`. Then ask: are you seeing the same thing across multiple sources? If yes, go to Q5B. If no, keep collecting. **Stop here.**
- **A pattern across multiple sources** → add to `_discovery/_findings/` if not already there. Go to Q5B.
- **An interpreted pattern — you know what it means, not just what it is** → add to `_discovery/_insights/` if not already there. Go to Q6.

**Q5B — Saturation check.** Are new signals telling you something new, or confirming what you already think you're seeing? If new signals keep surprising you, keep collecting. If they're confirming a pattern, go to Q5C.

**Q5C — Can you interpret the pattern?** What does this finding mean for the people experiencing it?
- **Yes** → write it as an insight in `_discovery/_insights/`. Go to Q6.
- **Not yet** → stay in `_discovery/_findings/`. Come back when you can interpret it. **Stop here.**

---

## Q6. Can you frame a problem?

Can you state who experiences this, under what conditions, and what it costs them?

- **Yes, clearly** → go to Q7.
- **Started but not complete** → continue drafting the discovery output. Use the problem hypothesis template. Come back when you can answer yes. **Stop here.**
- **Not yet** → your insight may be too broad or not tied to a specific person and situation. Refine before proceeding. **Stop here.**

---

## Q7. Has this problem been worked on before?

Check `_index.md` and `_problems/`.

- **Yes, existing problem folder** → is the framing still accurate?
  - Still accurate → reference your insight from the existing discovery output. Go to Q8.
  - Shifted → create a new problem framing. Mark the existing one as superseded. Go to Q8.
- **No** → create a new problem folder. Assign the next available ID. Add to `_index.md`. Go to Q8.

---

## Q8. Do you have evidence to validate this problem framing?

- **Yes — external source cited, framed as user problem, confirmed by someone who experiences it** → approve the discovery output. Go to Q9.
- **Partially — some evidence but gaps remain** → continue research. Come back when evidence is complete. **Stop here.**
- **No — proceeding on assumption** → log a risk entry. Flag the discovery output as UNVALIDATED. Define your validation signal and set a review checkpoint. Go to Q9.

---

## Q9. How well do you understand the solution?

- **No idea yet** → you need Loop 2. Start with a Decision Frame. **Go to Loop 2.**
- **Have a candidate direction but untested** → enter Loop 2 with it as one concept to evaluate, not the answer. **Go to Loop 2.**
- **Have a validated solution — tested with real users** → go to Q12.
- **Solving a known, well-established pattern with no product-specific risk** → run a short stress-test: write the Decision Frame, AI challenge pass, document alternatives considered. Log the decision. Go to Q12.

---

## Q10. Where are you in the sprint?

- **Writing the Decision Frame** → continue. Once complete, move to concept generation.
- **Generating or evaluating concepts** → continue. Once you have 2–3 directions, run the AI challenge pass and make the call.
- **Concept chosen, building prototype** → continue. Once the prototype is ready, recruit users.
- **Prototype built, not yet tested** → recruit minimum 3–5 real users and run sessions. Go to Q11 after testing.

---

## Q11. What did testing tell you?

- **Concept validated — users understood it and it addressed the problem** → complete the design output. Go to Q12.
- **Concept partially validated — some things worked, some didn't** → iterate the design and retest, or document the uncertainty in the design output with confidence level noted. Go to Q12.
- **Concept invalidated — wrong direction** → return to concept generation. The problem framing may also need revisiting. Go to Q9.
- **Not enough signal** → run more sessions or recruit different participants. **Stop here.**

---

## Q12. Is the design output complete?

Check all sections are filled, including:

- [ ] Chosen concept and reasoning
- [ ] Rejected directions with conditions to revisit
- [ ] Validation evidence and confidence level
- [ ] Hard constraints
- [ ] Feedback instrumentation requirements (Section 8)
- [ ] Open questions resolved

- **Yes, all complete** → go to Q13.
- **No, gaps remain** → resolve them before proceeding. A spec built on an incomplete design output produces the wrong thing. **Stop here.**

---

## Q13. Are you ready to build?

- [ ] Design output approved
- [ ] Adapter Guide ready for your chosen SDD tooling
- [ ] Feedback instrumentation requirements mapped to `[FEEDBACK]` ACs in the spec

All checked → hand off to your SDD tooling. **You're in Loop 3.**

Not all checked → resolve the gaps first.

---

## Q14. What happened after shipping?

- **Outcome metrics moved — problem solved** → mark done. Update the Opportunity Map. Archive if appropriate. **Done.**
- **Metrics flat — solution didn't move the needle** → the problem framing may be wrong. Go to Q6 with fresh eyes. Don't iterate on a solution to the wrong problem.
- **Concept needs iteration — direction right, execution wrong** → go to Q10 and re-enter the sprint with test data.
- **UNVALIDATED brief checkpoint reached** → return to Q8 and validate the problem assumption now, or make another explicit risk decision.
- **Too early to tell** → define how long you'll monitor and what signal would trigger a decision. Come back when you have it. **Stop here.**

---

## Routing summary

| Where you are | Start at |
|---|---|
| Have a hunch, nothing confirmed | Q4 |
| Have observations or signals | Q5 |
| Have a pattern, need to interpret it | Q5B |
| Have an insight, no problem framing yet | Q6 |
| Problem identified, framing not started | Q6 |
| Problem framing in progress | Q6 |
| Problem framed, need validation | Q8 |
| Problem validated, no solution yet | Q9 |
| Have a candidate solution, untested | Q9 |
| Mid-sprint | Q10 |
| Post-test, deciding whether to proceed | Q11 |
| Have a validated design output | Q12 |
| Ready to build | Q13 |
| Shipped, reviewing outcomes | Q14 |
| Have a preformed solution, no problem | Q3 |
| Returning to existing work | Q1 |
| Not sure where you are | Q1 |
