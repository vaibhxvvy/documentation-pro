# KNOWLEDGE_QUALITY.md — Knowledge Quality Evaluation System

## Purpose

This module defines the standards for evaluating the quality of knowledge in a
publication: whether the content is correct, complete, consistent, readable,
and pedagogically sound.

Technical correctness and structural compliance (covered in QUALITY.md) are
necessary but not sufficient. A document can pass all structural checks while
still containing shallow coverage, inconsistent terminology, poor examples,
or weak pedagogical design.

KNOWLEDGE_QUALITY.md evaluates the substance of what is written, not the form.

## When to Load

Load during the QA phase, after QUALITY.md structural checks pass.
Applies to all publication types, with the pedagogical dimensions most relevant
to educational publications.

## Dependencies

```
Writing complete → QUALITY.md structural checks → KNOWLEDGE_QUALITY.md → delivery
```

---

## Dimension 1: Coverage

Coverage measures whether the publication addresses the full scope promised
by its blueprint and title.

### Coverage Evaluation

```
COVERAGE AUDIT
──────────────────────────────────────────────────────────────
For every topic listed in the Publication Blueprint (in-scope):
  □ Fully covered — the topic is addressed at appropriate depth
  □ Partially covered — the topic is mentioned but not adequately developed
  □ Missing — the topic is absent despite being in scope

For every major concept in the domain (per CURRICULUM.md knowledge map):
  □ Present and explained
  □ Present but shallow (expand or add cross-reference)
  □ Absent (determine: in-scope or out-of-scope?)

Coverage score: [Fully covered topics] / [Total in-scope topics]
Minimum acceptable: 90% fully covered
──────────────────────────────────────────────────────────────
```

### Coverage Rules

1. **No orphan sections.** Every section in the table of contents must contain
   substantive content. A section that is two paragraphs when the topic warrants
   ten is an undercoverage failure.

2. **No scope creep.** Topics not in the blueprint that appear in the document
   must be explicitly justified. If they are genuinely valuable, update the blueprint.
   If not, remove them.

3. **Depth calibration.** The depth of coverage must match the stated audience level
   and the topic's centrality:
   - Core concepts: exhaustive coverage
   - Supporting concepts: adequate coverage
   - Advanced topics: sufficient for stated level
   - Out-of-scope topics: reference only (with pointer to authoritative source)

---

## Dimension 2: Accuracy

Accuracy is covered primarily in SYSTEM.md and QUALITY.md. This module adds
the knowledge-level accuracy check.

### Accuracy Evaluation

For every technical claim in the document:

```
ACCURACY AUDIT
──────────────────────────────────────────────────────────────
□ Claim is verifiable from a cited primary source
□ Claim version/date is specified where it could change over time
□ No claim is stated as universal that is context-dependent
□ No claim is presented as current that was only true in older versions
□ Quantitative claims (performance figures, benchmarks) cite methodology
□ Security claims (guarantees, vulnerabilities) cite CVEs or papers
□ No claim contradicts another claim in the same document
──────────────────────────────────────────────────────────────
```

### Common Accuracy Failures

| Failure | Example | Correct Approach |
|---|---|---|
| Version anchoring | "The default is 5" without specifying version | "As of v3.2, the default is 5 [cite]" |
| Overgeneralization | "TCP guarantees delivery" | "TCP guarantees delivery within a single connection (not across network partitions)" |
| Contradictory claims | Ch. 3 says X; Ch. 7 says not-X | Reconcile and add cross-reference |
| Outdated information | Benchmark from 2018 presented as current | Update or explicitly date: "2018 benchmark [cite]" |
| Missing context | "This approach is faster" | "Faster than Y in Z conditions [cite]" |

---

## Dimension 3: Consistency

Consistency covers three domains: terminology, explanation style, and visual style.

### Terminology Consistency

Run a terminology audit (see LONG_DOCUMENT.md § Terminology Control):

```
TERMINOLOGY AUDIT
──────────────────────────────────────────────────────────────
For every technical term in the Terminology Registry:
  □ Used identically in every chapter
  □ Defined at first use in every chapter where it appears
  □ No synonyms used without explicit equivalence declaration
  □ Capitalization consistent throughout

Failure: [term] used as "[variant A]" in Ch. N and "[variant B]" in Ch. M
Fix: Standardize to one form. Update all occurrences. Document in registry.
──────────────────────────────────────────────────────────────
```

### Explanation Consistency

The same concept must not be explained differently in different parts of the document
unless the difference is intentional (e.g., simplified explanation early, rigorous
explanation later with explicit acknowledgment of the simplification).

```
EXPLANATION CONSISTENCY CHECK
──────────────────────────────────────────────────────────────
For every concept defined in the Glossary:
  □ Definition in chapter of introduction matches Glossary entry
  □ All subsequent uses are consistent with the Glossary definition
  □ No chapter redefines a concept already defined without explicit "Note: revised
    definition" language
──────────────────────────────────────────────────────────────
```

### Visual Consistency

See VISUAL_PLANNER.md § Visual Consistency Standards and LONG_DOCUMENT.md § Visual Consistency.

```
VISUAL CONSISTENCY CHECK
──────────────────────────────────────────────────────────────
□ Same color palette used across all diagrams
□ Same font used in all diagrams
□ Same node shape conventions used throughout
□ Arrow styles consistent
□ Figure numbering sequential and correct
□ Caption format identical across all figures
──────────────────────────────────────────────────────────────
```

---

## Dimension 4: Terminology

Terminology quality evaluates whether the publication uses domain terms correctly
and introduces them effectively.

### Terminology Quality Checks

```
TERMINOLOGY QUALITY AUDIT
──────────────────────────────────────────────────────────────
□ Every technical term is defined at first use
□ Definitions are accurate (cross-checked against authoritative sources)
□ Terms not defined here are explicitly marked as prerequisites
□ Acronyms are spelled out at first use in every chapter
□ Informal terms are not used in place of technical terms without justification
□ Terms that have multiple domain-specific meanings are disambiguated
□ Glossary is complete: every defined term in the text is in the Glossary
□ Glossary is accurate: no entry contradicts the text
──────────────────────────────────────────────────────────────
```

---

## Dimension 5: Readability

Readability evaluates whether the text is accessible to the stated audience.

### Readability Evaluation

```
READABILITY AUDIT
──────────────────────────────────────────────────────────────
Sentence-level:
  □ No sentence exceeds 40 words (SYSTEM.md rule)
  □ Sentence length varies (short and long alternated)
  □ Active voice used throughout (STYLE_GUIDE.md rule)
  □ No ambiguous pronouns (it, they, this — without clear referent)

Paragraph-level:
  □ One topic per paragraph
  □ Paragraphs 3–7 sentences (SYSTEM.md rule)
  □ Transition between paragraphs is smooth

Section-level:
  □ Section opens by stating its purpose
  □ Section closes with a brief conclusion or transition
  □ No section ends abruptly without signaling what comes next

Chapter-level:
  □ Chapter opens with learning objectives (educational) or purpose statement
  □ Chapter closes with summary and takeaways
  □ Chapter is internally coherent (logical progression of ideas)

Audience calibration:
  □ Vocabulary matches stated audience level
  □ No jargon for beginners without definition
  □ No over-explanation for experts
──────────────────────────────────────────────────────────────
```

---

## Dimension 6: Completeness

Completeness evaluates whether every section is fully written (no stubs or placeholders).

### Completeness Checks

```
COMPLETENESS AUDIT
──────────────────────────────────────────────────────────────
□ No TODO, TBD, or placeholder text in any section
□ No [PLACEHOLDER] or [INSERT X HERE] in the document
□ Every code listing runs and produces stated output
□ Every figure is created (not described as "Figure N will show X")
□ Every table has content in all cells (no empty cells without reason)
□ All exercises have questions AND expected outputs or solutions
□ All "Further Reading" entries have annotations
□ Bibliography has no entries with missing required fields
□ All appendices have content
──────────────────────────────────────────────────────────────
```

---

## Dimension 7: Visual Quality

Visual quality evaluates whether diagrams and figures communicate effectively.

### Visual Quality Checks

```
VISUAL QUALITY AUDIT
──────────────────────────────────────────────────────────────
For every diagram:
  □ Diagram communicates its intended information clearly
  □ No unnecessary complexity (remove elements that add no information)
  □ Labels are descriptive (not cryptic abbreviations)
  □ Direction of flow is clear (no ambiguous arrows)
  □ Legend present if non-standard symbols are used
  □ Readable at 100% zoom and at print resolution (test at 8pt minimum)
  □ Colorblind accessible (interpretable in grayscale)
  □ Caption explains what to notice (not just what is shown)

For every screenshot:
  □ Resolution adequate for print/screen target
  □ UI elements are legible
  □ Annotation marks (callouts, arrows) are clear

For every table:
  □ Column headers are descriptive
  □ Data is aligned consistently
  □ Units specified where applicable
  □ Sorted logically (not arbitrary)
──────────────────────────────────────────────────────────────
```

---

## Dimension 8: Citation Quality

Citation quality is covered in CITATIONS.md. This module adds knowledge-level checks.

### Citation Quality Checks

```
CITATION QUALITY AUDIT
──────────────────────────────────────────────────────────────
□ Every non-trivial technical claim has a citation
□ Citations are primary sources (not blog summaries of papers)
□ Citations are current (recency appropriate to the claim type)
□ Citations are accessible (links resolve, DOIs work)
□ The cited source actually supports the claim (not tangential)
□ Conflicting sources are acknowledged and adjudicated
□ No "common knowledge" claims that are actually contested
──────────────────────────────────────────────────────────────
```

---

## Dimension 9: Example Quality

### Example Quality Checks

```
EXAMPLE QUALITY AUDIT
──────────────────────────────────────────────────────────────
For every worked example:
  □ Example is complete (no "and so on" shortcuts)
  □ Example is realistic (not a trivial toy that doesn't match real use)
  □ Example is annotated (non-obvious lines explained)
  □ Example produces exactly the stated output when run
  □ Example uses the stated library version / tool version
  □ Example demonstrates the concept being explained (not a tangential use)
  □ At least one example per major concept

Example progression:
  □ First example in a section is the simplest possible case
  □ Later examples increase in complexity
  □ Final example in a chapter integrates multiple concepts

Counterexamples (showing what NOT to do):
  □ Clearly marked as incorrect (e.g., with ✗ or "Incorrect:" label)
  □ The mistake is explained
  □ The correction is shown
──────────────────────────────────────────────────────────────
```

---

## Dimension 10: Pedagogical Quality

Pedagogical quality applies to educational publications only.
Skip this dimension for purely reference publications.

### Pedagogical Quality Checks

```
PEDAGOGICAL QUALITY AUDIT
──────────────────────────────────────────────────────────────
Learning design:
  □ Learning objectives are measurable (action verbs, specific outcomes)
  □ Content fully addresses all stated learning objectives
  □ Bloom's Taxonomy level appropriate for audience and chapter
  □ Progressive difficulty within and across chapters

Concept introduction:
  □ Every abstraction introduced through a concrete example first
  □ Analogies used for non-intuitive concepts
  □ Common mistakes addressed before or after worked examples
  □ "Why it matters" motivation present before "how it works"

Knowledge consolidation:
  □ Summary accurately reflects chapter content
  □ Key Takeaways are self-contained (understandable without the chapter)
  □ Knowledge check tests the right level (not too easy, not too hard)
  □ Exercises require application (not just recall)

Prerequisite respect:
  □ No concept used before it is introduced
  □ External prerequisites explicitly stated
  □ Chapter dependency graph is respected
──────────────────────────────────────────────────────────────
```

---

## Dimension 11: Technical Correctness

Technical correctness evaluates domain-specific accuracy beyond citation checking.

### Technical Correctness Checks

For software documentation:
```
□ All code compiles/runs in the stated environment
□ API call signatures match official documentation
□ Configuration option names and values match official documentation
□ Command flags and syntax match tool version cited
□ Error codes and messages match actual system behavior
□ Security guidance is current (not deprecated approaches)
□ Performance claims include environment and measurement methodology
```

For protocol documentation:
```
□ Normative language (MUST, SHOULD, MAY) used correctly per RFC 2119
□ Protocol message formats match authoritative specification
□ State machine transitions are complete and correct
□ Edge cases (timeout, retry, error) are addressed
```

---

## Knowledge Quality Report

After running all 11 dimensions, produce a Knowledge Quality Report:

```
KNOWLEDGE QUALITY REPORT
════════════════════════════════════════════════════════════
Project: [Title]
Date: [Date]
Evaluator: Documentation Agent

DIMENSION SCORES
────────────────────────────────────────────────────────────
1.  Coverage            [ PASS | PARTIAL | FAIL ] — Score: [N]%
2.  Accuracy            [ PASS | PARTIAL | FAIL ]
3.  Consistency         [ PASS | PARTIAL | FAIL ]
4.  Terminology         [ PASS | PARTIAL | FAIL ]
5.  Readability         [ PASS | PARTIAL | FAIL ]
6.  Completeness        [ PASS | PARTIAL | FAIL ]
7.  Visual Quality      [ PASS | PARTIAL | FAIL ]
8.  Citation Quality    [ PASS | PARTIAL | FAIL ]
9.  Example Quality     [ PASS | PARTIAL | FAIL ]
10. Pedagogical Quality [ PASS | PARTIAL | FAIL | N/A ]
11. Technical Correctness [ PASS | PARTIAL | FAIL ]

ISSUES FOUND
────────────────────────────────────────────────────────────
[Issue 1]: Dimension N — [Description] — Severity: HIGH / MEDIUM / LOW
[Issue 2]: Dimension M — [Description] — Severity: HIGH / MEDIUM / LOW
...

DISPOSITION
────────────────────────────────────────────────────────────
[ ] PUBLICATION READY — all dimensions PASS
[ ] REQUIRES REVISION — [N] HIGH severity issue(s)
[ ] ACCEPTABLE WITH NOTES — only LOW/MEDIUM issues; document known limitations
════════════════════════════════════════════════════════════
```

---

## Related Modules

- **QUALITY.md** — Structural QA runs before this module. Load QUALITY.md first.
- **SYSTEM.md** — Accuracy and consistency rules originate here.
- **STYLE_GUIDE.md** — Readability rules originate here.
- **HANDBOOK.md** — Pedagogical quality dimension applies to handbooks.
- **LONG_DOCUMENT.md** — Consistency dimension for large documents.
- **CITATIONS.md** — Citation quality dimension details.
- **VISUAL_PLANNER.md** — Visual quality standards.
- **SUPPORTING_MATERIAL.md** — Completeness dimension includes supporting material.

---

## Version

```
Module:    KNOWLEDGE_QUALITY.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Position:  QA phase, after QUALITY.md structural checks
```
