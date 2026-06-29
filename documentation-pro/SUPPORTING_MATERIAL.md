# SUPPORTING_MATERIAL.md — Supporting Material Generation System

## Purpose

This module defines how to evaluate and generate all supporting materials that
accompany a publication: glossaries, appendices, FAQs, cheat sheets, reference
cards, exercise solutions, bibliographies, indexes, and more.

Supporting material is not optional decoration. Missing supporting material degrades
publication quality for the reader. A handbook without a glossary forces readers to
remember definitions. A reference without an index is unusable. Evaluate every
supporting material type for every publication.

## When to Load

Load during the publication planning phase, after PUBLICATION_TYPES.md has determined
the publication type. Evaluate which supporting materials to generate before writing begins.
Return to this module during the build phase to generate outstanding materials.

## Dependencies

```
PUBLICATION_TYPES.md → SUPPORTING_MATERIAL.md (planning phase)
HANDBOOK.md + DOCUMENTATION.md → SUPPORTING_MATERIAL.md (generation phase)
```

---

## Supporting Material Decision Matrix

For every publication, evaluate each material against the criteria below.

| Material | Handbooks | Courses | References | Guides | RFCs | Whitepapers |
|---|---|---|---|---|---|---|
| Glossary | **Required** | **Required** | Recommended | Optional | Optional | Optional |
| Index | **Required** | Recommended | **Required** | Optional | Optional | No |
| Bibliography | **Required** | **Required** | **Required** | Recommended | **Required** | **Required** |
| Solutions Appendix | **Required** | **Required** | N/A | N/A | N/A | N/A |
| Cheat Sheets | Recommended | Recommended | Optional | Optional | No | No |
| Reference Card | Recommended | Recommended | Recommended | Optional | No | No |
| Quick Start Guide | Recommended | Recommended | Recommended | Optional | No | No |
| FAQ | Recommended | Recommended | Recommended | **Required** | No | Optional |
| Exercises | **Required** | **Required** | Optional | No | No | No |
| Review Questions | **Required** | **Required** | No | No | No | No |
| Further Reading | **Required** | **Required** | Recommended | Optional | Recommended | Recommended |
| Acronym List | Recommended | Recommended | Recommended | Optional | Optional | Optional |
| Notation Reference | When math | When math | When math | No | No | No |
| Change Log | No | No | Recommended | Recommended | **Required** | No |
| Conformance Table | No | No | No | No | **Required** | No |
| Errata Section | For print | For print | For print | No | Recommended | No |

**Required** = Must be included  
**Recommended** = Include unless scope is very constrained  
**Optional** = Include when it adds value  
**No** = Typically not applicable  
**N/A** = Not applicable by definition

---

## Material 1: Glossary

### When Required

Required for: all handbooks, all courses, any publication introducing 5+ new terms.

### Structure

```
# Glossary

All technical terms defined in this publication are listed alphabetically below.
Each entry includes the chapter where the term is first introduced.

## A

**Abstraction** *(noun)* — A simplified model that hides unnecessary detail.
In software, an abstraction exposes only the relevant properties of a system.
*(First defined: Chapter 2, Section 2.1)*

**Algorithm** *(noun)* — A finite sequence of well-defined instructions that
produces a result for any valid input. *(First defined: Chapter 1, Section 1.3)*

## B

[Continue alphabetically]
```

### Glossary Generation Rules

1. Collect every term introduced across all chapters during writing
2. Write the definition independently of the surrounding chapter context
3. Include the chapter reference for every entry
4. Group alphabetically under letter headers
5. Include synonyms where they exist: `**Goroutine** — see *green thread*`
6. Do not define terms the audience profile already knows
7. Maximum two sentences per definition

---

## Material 2: Index

### When Required

Required for: print handbooks, any publication over 20,000 words, all reference manuals.

### Index Entry Selection Rules

Index every occurrence of:
- All glossary terms (primary entry = definition location)
- Named algorithms, data structures, patterns
- Named configuration options, flags, parameters, environment variables
- Function, method, and class names in SDK/API documentation
- Error messages and codes
- Proper nouns (tools, languages, versions, specifications)
- Concept names that are central to the publication

Do not index:
- Incidental mentions that add no information to the reader
- Preface and introduction
- Terms only used once (include in glossary instead)

### Index Format

```
# Index

## A

Abstraction, 12, 45–47, 89
  layers of, 13
  vs. encapsulation, 46
Algorithm
  binary search, 78–80
  definition, 7
  time complexity, 81–84

## B

Binary search — see Algorithm, binary search
```

### Index for Markdown/HTML Documents

When producing index for non-LaTeX output, use a definition list or table at the end
of the document. For LaTeX, use `\index{}` commands in the source per LATEX.md.

---

## Material 3: Bibliography / Further Reading

### When Required

Required for all publications that cite external sources.

### Bibliography vs. Further Reading

| Type | Contents | Format |
|---|---|---|
| **Bibliography** | Sources cited in the text | BibTeX / numbered list at end |
| **Further Reading** | Additional resources for readers who want more depth | Annotated list organized by chapter or topic |

Both are often needed. Bibliography = sources used. Further Reading = sources recommended.

### Further Reading Format

```
## Further Reading

### Chapter 1: [Title]

**[Author], *[Title]*, [Publisher], [Year]** — [2–3 sentence annotation explaining
what the book covers, who it is for, and how it extends Chapter 1's content.]

**[Author], "[Article Title]", [Publication], [Year]** — [Annotation]

### Chapter 2: [Title]

[Continue by chapter]

### General References

[Books or resources relevant to the entire publication]
```

### Annotation Rules

Every Further Reading entry must include a 2–3 sentence annotation:
- What the resource covers
- Who it is for (level, background)
- Why it is recommended in the context of this publication

Do not list resources without annotations. Unannotated lists waste the reader's time.

---

## Material 4: Solutions Appendix

### When Required

Required when: the publication includes exercises with non-trivial answers.
Recommended for: all handbooks and courses.

### Solutions Format

```
# Appendix A: Exercise Solutions

## Chapter 1

### Exercise 1.1: [Title]

**Solution**:

[Complete solution with full explanation. For code exercises: working code with
output. For design exercises: one valid design with rationale. For analysis exercises:
the complete reasoning chain, not just the answer.]

**Common mistakes**:
- [Mistake 1]: [Why it is wrong and how to avoid it]
- [Mistake 2]: [Why it is wrong]

### Exercise 1.2: [Title]

[Solution]

## Chapter 2

[Continue by chapter]
```

### Solutions Quality Rules

1. Every solution must be complete — the reader should not need the chapter to understand the solution
2. Code solutions must include expected output
3. Explain why the correct answer is correct
4. Flag common mistakes for each exercise
5. For open-ended exercises, provide one valid solution and note that other valid approaches exist

---

## Material 5: Cheat Sheets

### When Required

Recommended for: all chapters that introduce syntax, commands, formulas, or rules
that the reader will need to recall during practical work.

### Cheat Sheet Format

```
# Cheat Sheet: [Chapter N Title]

## Syntax Quick Reference

| Operation | Syntax | Example |
|---|---|---|
| [Operation] | `[syntax]` | `[example]` |

## Key Commands

```bash
# [Purpose]
[command] [args]

# [Purpose]
[command] [args]
```

## Decision: When to Use X vs Y

| Situation | Use |
|---|---|
| [Condition] | X |
| [Condition] | Y |
| [Condition] | Either |

## Top 3 Errors and Fixes

| Error | Cause | Fix |
|---|---|---|
| `[error message]` | [Root cause] | [How to fix] |

## Key Formulas (if applicable)

[Formula]: [Label and brief explanation]
```

### Cheat Sheet Placement

- Single-page cheat sheets: include at the end of each chapter as a summary
- Collected cheat sheets: compile into Appendix D
- For print: format as A4/letter landscape for easy printing

---

## Material 6: FAQ

### When Required

Required for: user-facing documentation, operations manuals.
Recommended for: any technical documentation where common questions are known.

### FAQ Generation Rules

1. Identify the 10–20 most common questions a reader will have
2. Sources: support channels, Stack Overflow, GitHub Issues, documentation feedback
3. Every answer is self-contained (not "see Section X" as the entire answer)
4. Group questions by topic
5. Keep answers concise (2–8 sentences + optional code)

### FAQ Format

```
# Frequently Asked Questions

## Installation

**Q: I get "permission denied" when running the install script. What do I do?**

A: This typically happens when... [Answer]. To fix it:
```bash
[fix command]
```

**Q: Which versions of [dependency] are supported?**

A: Versions X.Y through A.B are supported. Version C.D is not supported because...

## Configuration

**Q: [Question]**

A: [Answer]

[Continue by category]
```

---

## Material 7: Reference Card

### When Required

Recommended for: all publications targeting practitioners who will use the material
during daily work.

A reference card is more compressed than a cheat sheet: it fits on one side of one
page and is designed for printing and posting.

### Reference Card Contents

- 3–5 most critical rules or principles
- Essential commands (5–10 maximum)
- Key syntax patterns
- Critical configuration options
- Contact/resource links

No explanations. Labels only. If it needs explaining, it belongs on a cheat sheet, not a reference card.

---

## Material 8: Quick Start Guide

### When Required

Recommended for: complex systems where new users need to get a working result in
under 30 minutes before reading the full documentation.

### Quick Start Structure

```
# Quick Start: [System Name]

**You will have:** [Specific result] in **[N minutes]**.

## Step 1: [Install/Setup] (N minutes)
[Minimal setup — only what is absolutely required]

## Step 2: [First Operation] (N minutes)
[The simplest possible working example]

## Step 3: [Verify It Works] (2 minutes)
[How to confirm success]

## What's Next

You have [what they accomplished]. To learn more:
- [Topic A] → Chapter N
- [Topic B] → Chapter M
- [Full documentation] → Table of Contents
```

---

## Material 9: Acronym List

### When Required

Recommended for: publications over 20,000 words that use 10+ acronyms.

### Format

```
# Acronym Reference

| Acronym | Full Form | First Defined |
|---|---|---|
| API | Application Programming Interface | Chapter 1 |
| CLI | Command-Line Interface | Chapter 3 |
```

---

## Material 10: Notation Reference

### When Required

Required for: any publication containing mathematical notation, formal notation, or
non-standard symbols.

### Format

```
# Notation Reference

| Symbol | Meaning | Example |
|---|---|---|
| O(n) | Big-O complexity notation | O(log n) means logarithmic growth |
| ∀ | "For all" (universal quantifier) | ∀x ∈ S: x > 0 |
| ∃ | "There exists" (existential quantifier) | ∃x ∈ S: f(x) = 0 |
```

---

## Supporting Material Generation Checklist

Before delivering a publication, verify:

- [ ] Supporting material decision matrix evaluated for this publication type
- [ ] All **Required** materials present and complete
- [ ] All **Recommended** materials present (or explicitly noted as deferred)
- [ ] Glossary: all technical terms defined, alphabetically ordered, with chapter references
- [ ] Index: generated for publications over 20,000 words
- [ ] Bibliography: all cited sources in correct format
- [ ] Further Reading: annotated (not bare lists)
- [ ] Solutions: complete explanations, not just answers
- [ ] Cheat sheets: generated for all syntax-heavy chapters
- [ ] FAQ: answers are self-contained
- [ ] All appendices labeled (A, B, C...) and cross-referenced from main text

---

## Related Modules

- **HANDBOOK.md** — Defines which materials are required for handbooks.
- **QUALITY.md** — Supporting material completeness is a QA checkpoint.
- **CITATIONS.md** — Bibliography generation follows CITATIONS.md rules.
- **LATEX.md** — Index generation uses `\index{}` commands and `makeindex`.
- **EXPORT.md** — Supporting material formatting per output format.

---

## Version

```
Module:    SUPPORTING_MATERIAL.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Position:  Planning phase and generation phase
```
