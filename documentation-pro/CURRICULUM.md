# CURRICULUM.md — Curriculum Design Workflow

## Purpose

This module defines the planning stage required before writing any educational publication.
Its job is to organize raw knowledge into a teachable, sequenced curriculum — transforming
a subject domain into a structured learning experience.

Documentation is not always educational. Load this module only when the publication
has a pedagogical intent: the reader is expected to build knowledge progressively.

## Scope

Curriculum design is the bridge between research and writing. It sits after RESEARCH.md
and before DOCUMENTATION.md or HANDBOOK.md in the workflow.

## When to Load

Load when producing:
- Handbooks (any level)
- Courses and course materials
- Workshop and lab manuals
- Textbooks
- Tutorial series
- Training programs
- Any document where knowledge is built chapter-by-chapter

## When NOT to Load

Do not load for:
- API references
- RFCs and specifications
- Architecture documents
- Whitepapers
- Any document that is reference-first rather than learning-first

## Dependencies

```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md → CURRICULUM.md → HANDBOOK.md → writing
```

---

## The Educational Publication Workflow

For educational publications, the full workflow is:

```
[1] RESEARCH
     Research the domain deeply.
     Collect all concepts, terms, techniques, tools, and examples.
     Do not impose structure yet. Collect everything first.

     ↓

[2] KNOWLEDGE ORGANIZATION
     Group raw research into concept clusters.
     Identify core concepts vs supporting concepts vs advanced topics.
     Identify prerequisite relationships.
     Identify common mistakes and misconceptions.

     ↓

[3] CURRICULUM DESIGN
     Sequence concept clusters into a learning path.
     Define the handbook's scope (what is included, what is excluded).
     Define chapter boundaries.
     Define the target audience level.
     Define learning objectives at the handbook level.

     ↓

[4] CHAPTER PLANNING
     For each chapter: define purpose, objectives, key concepts, examples needed,
     diagrams needed, exercises, and cross-references.
     See CHAPTER_PLAN.md.

     ↓

[5] VISUAL PLANNING
     Identify which chapters need diagrams.
     Plan diagrams before writing begins.
     See VISUAL_PLANNER.md.

     ↓

[6] WRITING
     Write chapters in dependency order.
     See HANDBOOK.md and DOCUMENTATION.md.

     ↓

[7] ILLUSTRATIONS
     Generate all planned diagrams and figures.
     See DIAGRAMS.md and FIGURES.md.

     ↓

[8] REVIEW
     Apply QUALITY.md full checklist.
     Check pedagogical quality (see QUALITY.md § Educational Quality).

     ↓

[9] PUBLISHING
     Apply EXPORT.md for target format.
     Apply BUILD.md for compilation.
```

---

## Phase 1: Knowledge Organization

After completing the research phase, organize collected knowledge into a structured
knowledge map. Do this before imposing chapter boundaries.

### Knowledge Organization Template

```
KNOWLEDGE MAP: [Subject]
════════════════════════════════════════════════════════════

CORE CONCEPTS (must know to function in this domain)
─────────────────────────────────────────────────────
1. [Concept] — [One-sentence definition] — [Prerequisite: none / Concept N]
2. [Concept] — [One-sentence definition] — [Prerequisite: Concept 1]
3. [Concept] — [One-sentence definition] — [Prerequisite: Concepts 1, 2]
...

SUPPORTING CONCEPTS (deepen understanding but not blocking)
───────────────────────────────────────────────────────────
1. [Concept] — [Definition] — [Which core concept it supports]
2. [Concept] — [Definition] — [Which core concept it supports]
...

ADVANCED TOPICS (require core + supporting knowledge)
──────────────────────────────────────────────────────
1. [Topic] — [Definition] — [Prerequisites: Core N, Supporting M]
2. [Topic] — [Definition] — [Prerequisites]
...

COMMON MISTAKES & MISCONCEPTIONS
─────────────────────────────────
1. [Mistake] — [Correct understanding] — [Which concept it relates to]
2. [Mistake] — [Correct understanding]
...

ESSENTIAL TOOLS & ECOSYSTEM
─────────────────────────────
1. [Tool] — [Role] — [When introduced]
2. [Tool] — [Role] — [When introduced]
...

TERMINOLOGY REFERENCE
──────────────────────
[Term]: [Definition] — [Synonyms if any] — [Related terms]
...
════════════════════════════════════════════════════════════
```

---

## Phase 2: Curriculum Design

With the knowledge map complete, design the curriculum by:

1. **Defining scope** — What is in, what is out, and why
2. **Selecting the learning path** — Linear, spiral, or branching
3. **Assigning concepts to chapters** — One primary concept cluster per chapter
4. **Identifying knowledge gaps** — Concepts the reader needs but won't have covered

### Learning Path Patterns

**Linear path**: Each chapter requires all previous chapters. Best for foundational
subjects where later concepts genuinely build on earlier ones (e.g., networking,
compilers, calculus).

```
Ch1 → Ch2 → Ch3 → Ch4 → Ch5
```

**Spiral path**: Core concepts are introduced simply early and revisited in depth later.
Best for subjects with layered complexity (e.g., operating systems, distributed systems).

```
Ch1(intro) → Ch2 → Ch3(deeper Ch1) → Ch4 → Ch5(deepest Ch1)
```

**Branching path**: Some chapters are independent after the core foundations.
Best for broad reference handbooks (e.g., data science, cloud platforms).

```
Ch1 → Ch2 → Ch3 ─┬─ Ch4 (branch A)
                  └─ Ch5 (branch B)
                  └─ Ch6 (branch C)
```

### Curriculum Blueprint Template

```
CURRICULUM BLUEPRINT: [Handbook Title]
════════════════════════════════════════════════════════════
Target Audience:      [Audience Profile — see HANDBOOK.md]
Learning Path:        [ ] Linear  [ ] Spiral  [ ] Branching
Handbook Level:       [ ] Beginner  [ ] Intermediate  [ ] Advanced
Estimated Length:     [N chapters, ~M words total]
Estimated Read Time:  [N hours reading + M hours practice]

SCOPE BOUNDARIES
────────────────
In scope:
  - [Topic A]
  - [Topic B]
Out of scope:
  - [Topic X — too advanced, see [reference]]
  - [Topic Y — prerequisite, covered in [reference]]

CHAPTER SEQUENCE
────────────────
Chapter 0: Introduction & Prerequisites
  Primary concept: [Setting expectations, environment setup]
  Estimated words: 1,500

Chapter 1: [Title]
  Primary concept: [Core Concept 1]
  Depends on: [nothing / Chapter 0]
  Estimated words: [N]

Chapter 2: [Title]
  Primary concept: [Core Concept 2]
  Depends on: [Chapter 1]
  Estimated words: [N]

[Continue for all chapters]

Chapter N: [Capstone Project / Reference]
  Primary concept: [Integration / reference]
  Depends on: [Chapters 1–N-1]
  Estimated words: [N]

APPENDICES PLANNED
──────────────────
  A: Solutions
  B: Glossary
  C: Further Reading
  D: Cheat Sheets
  E: Index

SUPPORTING MATERIAL
────────────────────
  [ ] Cheat sheets per chapter
  [ ] Mini-projects
  [ ] Knowledge checks
  [ ] Solutions appendix
  [ ] FAQ
  [ ] Quick start guide
════════════════════════════════════════════════════════════
```

---

## Phase 3: Concept Distribution

After designing the curriculum, verify that concept distribution is correct:

### Concept Distribution Rules

1. **No chapter is overloaded.** Each chapter should introduce 3–7 new core concepts.
   A chapter introducing 15 concepts is two chapters badly merged.

2. **No chapter is empty.** A chapter with one new concept is probably a section
   of an adjacent chapter.

3. **Core concepts are not split across chapters.** If two concepts are inseparable
   (you cannot understand one without the other), they belong in the same chapter.

4. **No forward references to undefined concepts.** You cannot use concept X in
   Chapter 3 if X is not introduced until Chapter 5.

5. **Prerequisites are always in earlier chapters.** Run a forward-reference check
   after distributing concepts: for every concept used in Chapter N, confirm it was
   introduced in Chapter 1 through N-1.

### Concept Distribution Verification

```
CONCEPT DISTRIBUTION AUDIT
───────────────────────────
For each chapter, list:
  - New concepts introduced (max 7)
  - Concepts used but not introduced here (must be from earlier chapters)
  - Concepts this chapter prepares for later chapters

If any concept used in Chapter N was introduced after Chapter N → STRUCTURAL ERROR.
Fix: move the concept introduction or change the chapter order.
```

---

## Phase 4: Terminology Standardization

Before writing begins, standardize all terminology across the curriculum.

### Terminology Rules

1. **Choose one term per concept.** If the field uses multiple synonyms (e.g.,
   "goroutine" / "fiber" / "green thread"), choose one as the primary term and
   introduce synonyms explicitly.

2. **Consistency across all chapters.** Once a term is chosen, it is used identically
   throughout every chapter.

3. **Glossary-first authoring.** All technical terms that will be introduced must
   be added to the glossary draft before chapter writing begins.

4. **Acronym control.** Every acronym is spelled out at first use in every chapter
   (not just the first chapter where it appears).

### Terminology Registry Template

```
TERMINOLOGY REGISTRY: [Handbook Title]
────────────────────────────────────────
Term          | Synonym(s)         | Introduced | Definition
──────────────┼────────────────────┼────────────┼──────────────────
[term]        | [alias1, alias2]   | Ch. N      | [brief definition]
```

---

## Curriculum Quality Checks

Before proceeding to CHAPTER_PLAN.md:

- [ ] Knowledge map complete: core, supporting, advanced concepts all identified
- [ ] Common mistakes and misconceptions catalogued
- [ ] Scope defined: in-scope and out-of-scope explicitly stated
- [ ] Learning path pattern chosen (linear / spiral / branching)
- [ ] Chapter sequence defined with dependencies
- [ ] No chapter has more than 7 new core concepts
- [ ] No forward references (concept used before introduced)
- [ ] Terminology registry complete
- [ ] Supporting material evaluated
- [ ] Appendix structure defined

---

## Related Modules

- **RESEARCH.md** — Prerequisite. Run research before curriculum design.
- **HANDBOOK.md** — Loads after this module. Uses curriculum output.
- **CHAPTER_PLAN.md** — Per-chapter planning. Runs after curriculum blueprint is complete.
- **VISUAL_PLANNER.md** — Diagram planning. Runs after chapter plans are complete.
- **PUBLICATION_TYPES.md** — Confirms this is the correct publication type.
- **QUALITY.md** — Validates pedagogical quality after writing.

---

## Version

```
Module:    CURRICULUM.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Position:  After RESEARCH.md, before HANDBOOK.md
```
