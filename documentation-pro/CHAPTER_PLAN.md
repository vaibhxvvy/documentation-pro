# CHAPTER_PLAN.md — Chapter Planning System

## Purpose

This module defines the mandatory planning stage for every chapter before writing begins.
No chapter may be written without a completed chapter plan. The plan defines the chapter's
purpose, objectives, scope, required content, and diagram needs — preventing incomplete
or structurally inconsistent chapters.

## When to Load

Load this module after CURRICULUM.md is complete and before writing any chapter.
Use it once per chapter, in the order defined by the curriculum blueprint.

## When NOT to Load

Skip per-chapter planning only for single-page reference content (cheat sheets,
quick reference cards, glossary entries). All substantive chapters require a plan.

## Dependencies

```
RESEARCH.md → CURRICULUM.md → CHAPTER_PLAN.md → [write chapter] → VISUAL_PLANNER.md
```

---

## The Chapter Plan

Every chapter plan consists of ten required fields. No field may be left blank.
If a field genuinely does not apply, write "N/A — [reason]".

### Chapter Plan Template

```
═══════════════════════════════════════════════════════════════
CHAPTER PLAN
═══════════════════════════════════════════════════════════════
Handbook:          [Handbook title]
Chapter Number:    [N]
Chapter Title:     [Working title — may change after writing]
Planned Length:    [N words approximate]
Target Audience:   [Level: Beginner / Intermediate / Advanced]

───────────────────────────────────────────────────────────────
1. PURPOSE
───────────────────────────────────────────────────────────────
[Why does this chapter exist? What gap does it fill in the reader's
knowledge? What capability does it unlock? 2–4 sentences.]

───────────────────────────────────────────────────────────────
2. LEARNING OUTCOMES
───────────────────────────────────────────────────────────────
After completing this chapter, the reader will be able to:

□ [Outcome 1 — action verb + specific measurable capability]
□ [Outcome 2]
□ [Outcome 3]
□ [Outcome 4 — optional]
□ [Outcome 5 — optional]

Bloom level distribution:
  □ Remember   □ Understand   □ Apply   □ Analyze   □ Evaluate   □ Create

───────────────────────────────────────────────────────────────
3. PREREQUISITES
───────────────────────────────────────────────────────────────
Required from earlier chapters:
  - [Chapter N, Section X]: [What the reader must know]
  - [Chapter M, Section Y]: [What the reader must know]

Required domain knowledge (pre-handbook):
  - [External concept]: [Level of mastery required]

Reader assumption: [One sentence describing what we assume the reader knows
entering this chapter]

───────────────────────────────────────────────────────────────
4. KEY CONCEPTS
───────────────────────────────────────────────────────────────
New concepts introduced this chapter (max 7):

1. [Concept] — [One-sentence definition]
2. [Concept] — [One-sentence definition]
3. [Concept] — [One-sentence definition]
4. [Concept] — [One-sentence definition]
...

Concepts used but defined elsewhere:
  - [Concept] → defined in Chapter N

───────────────────────────────────────────────────────────────
5. EXAMPLES REQUIRED
───────────────────────────────────────────────────────────────
Worked examples (complete, annotated, tested):

Example 1: [Title] — [What it demonstrates]
  Complexity: [ ] Simple  [ ] Moderate  [ ] Complex
  Environment: [Language/version/platform]

Example 2: [Title] — [What it demonstrates]
  Complexity: [ ] Simple  [ ] Moderate  [ ] Complex
  Environment: [Language/version/platform]

Example N: [Integrating example — combines multiple concepts from this chapter]

───────────────────────────────────────────────────────────────
6. VISUALS REQUIRED
───────────────────────────────────────────────────────────────
(See VISUAL_PLANNER.md for diagram type selection and creation rules)

Figure 1: [Title] — [Type: flowchart / architecture / sequence / etc.]
  Purpose: [What this diagram communicates]
  Priority: [ ] Essential  [ ] Helpful  [ ] Optional

Figure 2: [Title] — [Type]
  Purpose: [What this diagram communicates]
  Priority: [ ] Essential  [ ] Helpful  [ ] Optional

Tables:
  Table 1: [Title] — [Comparison / benchmark / feature matrix / reference]

───────────────────────────────────────────────────────────────
7. EXERCISES
───────────────────────────────────────────────────────────────
Exercise set (minimum 3, maximum 10):

Exercise 1: [Title] — Type: [Recall / Comprehension / Application / Analysis / Design]
  Difficulty: ⭐ / ⭐⭐ / ⭐⭐⭐
  Tests: [Which learning outcome(s)]

Exercise 2: [Title] — Type: [...]
  Difficulty: ⭐ / ⭐⭐ / ⭐⭐⭐
  Tests: [Which learning outcome(s)]

...

Knowledge check questions: [N questions planned — confirm/recall type]
Mini project: [ ] Yes — [brief description]  [ ] No

───────────────────────────────────────────────────────────────
8. SUMMARY
───────────────────────────────────────────────────────────────
Chapter summary (planned — write as complete sentences, 150–300 words):

[Draft the summary now. This forces clarity about what the chapter will actually
cover. If you cannot summarize it concisely before writing, the chapter scope
is unclear. Revise the scope, then write the summary.]

───────────────────────────────────────────────────────────────
9. REFERENCES
───────────────────────────────────────────────────────────────
Primary sources for this chapter's technical claims:

1. [Author, Title, Publisher/URL, Year] — [What it verifies]
2. [Author, Title, Publisher/URL, Year] — [What it verifies]
3. [Author, Title, Publisher/URL, Year] — [What it verifies]

All BibTeX entries to be added to bibliography.bib before writing begins.
Research confidence threshold: all sources must score ≥ 0.7 per RESEARCH.md.

───────────────────────────────────────────────────────────────
10. RELATED CHAPTERS
───────────────────────────────────────────────────────────────
Chapters this chapter depends on:
  → Chapter N: [specific dependency]
  → Chapter M: [specific dependency]

Chapters that depend on this chapter:
  ← Chapter P: [what they use from here]
  ← Chapter Q: [what they use from here]

Cross-references to insert while writing:
  - In Section [X], add cross-reference to Chapter [N] for deeper coverage of [topic]
  - In Section [Y], forward-reference Chapter [M] as "covered in more depth in Chapter M"

───────────────────────────────────────────────────────────────
PLAN APPROVED: [ ] Yes — proceed to writing
               [ ] No  — [reason and revisions needed]
═══════════════════════════════════════════════════════════════
```

---

## Validation Rules

The chapter plan must pass these checks before writing begins:

### Scope Validation

- [ ] Purpose is clear in 2–4 sentences
- [ ] Learning outcomes are measurable (use action verbs)
- [ ] No outcome is vague ("understand X" without specification)
- [ ] Bloom's taxonomy coverage is appropriate for the handbook level
- [ ] New concept count ≤ 7

### Prerequisite Validation

- [ ] All prerequisites are from chapters that precede this one in the curriculum
- [ ] No concept is used that has not been introduced
- [ ] External prerequisites are explicitly stated

### Content Validation

- [ ] At least 2 worked examples planned
- [ ] Final example integrates multiple concepts from this chapter
- [ ] Exercise types are varied (not all recall or all application)
- [ ] Exercise count is 3–10
- [ ] At least one exercise per learning outcome

### Visual Validation

- [ ] At least one visual is planned for chapters over 4,000 words
- [ ] All "Essential" visuals have a clear purpose statement
- [ ] Diagram types are selected appropriately (see VISUAL_PLANNER.md)

### Reference Validation

- [ ] At least 3 primary sources identified
- [ ] All sources have been evaluated (RESEARCH.md confidence score ≥ 0.7)
- [ ] BibTeX entries prepared before writing begins

### Summary Validation

- [ ] Summary is written before the chapter is written
- [ ] Summary can be written concisely (if not, chapter scope is too broad)

---

## Chapter Plan for Non-Educational Documents

For non-handbook chapters (technical book chapters, reference chapters), use this
simplified plan:

```
SECTION PLAN (non-educational)
───────────────────────────────────────────────────────────────
Document:       [Title]
Section:        [N.M Section Title]
Planned Length: [N words]
Purpose:        [What this section documents]
Key content:    [Bulleted list of what must be included]
Technical claims requiring citations: [List]
Diagrams required: [List with types]
Tables required: [List with types]
Cross-references: [List]
───────────────────────────────────────────────────────────────
```

---

## Integration with Writing Workflow

After the chapter plan is approved:

1. Run **VISUAL_PLANNER.md** to detail all planned diagrams
2. Prepare all bibliography entries (CITATIONS.md)
3. Write the chapter using the HANDBOOK.md chapter template
4. After completing the draft, verify all planned content is present:
   - All learning outcomes addressed in the text
   - All worked examples complete and annotated
   - All visuals created (not placeholder text)
   - All exercises written with expected output
   - Knowledge check written
   - Key takeaways written
   - Glossary entries collected
   - Cross-references inserted

---

## Related Modules

- **CURRICULUM.md** — Prerequisite. Chapter plan implements the curriculum blueprint.
- **HANDBOOK.md** — Chapter writing template. Filled after plan is complete.
- **VISUAL_PLANNER.md** — Expands Section 6 (Visuals Required) into full diagram specs.
- **RESEARCH.md** — All sources in Section 9 must meet research quality standards.
- **CITATIONS.md** — BibTeX entries for Section 9 references.
- **QUALITY.md** — Final chapter QA includes checking plan fulfillment.

---

## Version

```
Module:    CHAPTER_PLAN.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Position:  After CURRICULUM.md, before chapter writing
```
