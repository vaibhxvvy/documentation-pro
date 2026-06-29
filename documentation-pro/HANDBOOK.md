# HANDBOOK.md — Technical Handbook Generation System

## Purpose

This module defines how to plan, structure, and generate complete educational and
professional handbooks — documents that teach a subject progressively rather than
simply reference it. A handbook has explicit pedagogical intent: the reader begins
with less knowledge than when they finish.

## Scope

This module covers:
- Learning objective definition
- Audience analysis
- Prerequisite mapping
- Chapter sequencing and knowledge progression
- Progressive difficulty calibration
- Worked examples, exercises, and review material
- Supporting apparatus: glossary, appendix, index, cheat sheets
- Handbook types: beginner, intermediate, advanced, professional reference, training manual

## When to Load

Load this module when the task is any of:
- An educational handbook (any level)
- A training manual
- A learning guide
- A course textbook
- A workshop curriculum
- A professional reference book with progressive learning structure
- Any document where the reader is expected to build knowledge chapter by chapter

## When NOT to Load

Do not load this module for:
- API references (load DOCUMENTATION.md Template 2)
- RFC specifications (load DOCUMENTATION.md Template 4)
- Pure reference manuals with no learning progression
- Single-page guides or cheat sheets

## Dependencies

Load these before HANDBOOK.md:
- SKILL.md
- SYSTEM.md
- STYLE_GUIDE.md
- RESEARCH.md
- DOCUMENTATION.md

HANDBOOK.md extends DOCUMENTATION.md. Where the two conflict, HANDBOOK.md takes precedence
for educational publications. Load CURRICULUM.md alongside this module for full workflow.

---

## Phase 1: Audience Analysis

Before writing a single word, define the reader. Every handbook targets a specific
reader profile. The profile drives vocabulary, assumed knowledge, example selection,
and difficulty calibration.

### Audience Profile Template

```
AUDIENCE PROFILE
────────────────────────────────────────────────────────────
Handbook Title:       [Title]
Target Reader:        [Job title / role / student type]
Experience Level:     [ ] Beginner  [ ] Intermediate  [ ] Advanced  [ ] Expert
Domain Background:    [What the reader already knows]
Technical Background: [Programming languages, tools, systems they know]
Goal:                 [What the reader wants to accomplish after reading]
Motivation:           [Why this reader is reading — career, project, curiosity]
Time Available:       [Hours per week for study]
Reading Context:      [ ] Self-study  [ ] Classroom  [ ] Reference  [ ] On-the-job
────────────────────────────────────────────────────────────
```

### Calibration by Level

**Beginner handbook**:
- Assume no prior domain knowledge
- Define every technical term at first use
- Provide analogies from everyday experience
- Every concept gets a worked example before exercises
- Short chapters (2,000–4,000 words)
- Exercises are confirmatory (checks understanding, not extensions)

**Intermediate handbook**:
- Assume foundational domain knowledge
- Define specialized or advanced terms only
- Analogies optional; comparisons to known concepts preferred
- Worked examples focus on non-obvious cases
- Medium chapters (4,000–8,000 words)
- Exercises extend and challenge

**Advanced handbook**:
- Assume solid domain and implementation knowledge
- No definitions for standard terms; define only novel or contested terms
- Examples focus on edge cases, failure modes, and design tradeoffs
- Long chapters (6,000–12,000 words)
- Exercises are open-ended and project-oriented

**Professional reference book**:
- Assume expert-level background
- Maximally dense, reference-first structure
- Extensive cross-referencing between sections
- Examples are production-grade code, not illustrations
- Chapters are topic-complete, not sequentially dependent

---

## Phase 2: Learning Objective Definition

Every handbook must open with a global learning objective (the book's purpose) and
every chapter must open with chapter-level objectives.

### Global Learning Objectives Template

```
After completing [Handbook Title], the reader will be able to:

1. [Cognitive objective — understand, explain, describe a concept]
2. [Application objective — implement, configure, deploy something]
3. [Analysis objective — evaluate, compare, debug something]
4. [Synthesis objective — design, build, create something new]
5. [Domain objective — work effectively in [domain] context]

Approximate time to completion: [N hours of reading + N hours of practice]
Prerequisites: See Chapter 0 (Prerequisites).
```

### Chapter Learning Objectives Template

```
## Learning Objectives

After completing this chapter, you will be able to:

- [Concrete skill 1 — action verb + specific capability]
- [Concrete skill 2]
- [Concrete skill 3]

These objectives build on: [Chapter N, Section X] and [Chapter M, Section Y].
They are required by: [Chapter P] and [Chapter Q].
```

Use Bloom's Taxonomy verb hierarchy for objectives:
- **Remember**: list, name, recall, recognize
- **Understand**: explain, describe, summarize, interpret
- **Apply**: implement, execute, use, demonstrate
- **Analyze**: compare, differentiate, examine, break down
- **Evaluate**: critique, judge, assess, defend
- **Create**: design, build, construct, generate

Distribute objectives across levels. A chapter with only "remember" objectives is
too shallow. A beginner chapter with only "create" objectives is too steep.

---

## Phase 3: Prerequisite Mapping

Handbooks are not read in isolation. Every chapter depends on prior knowledge.
Map these dependencies explicitly before writing.

### Global Prerequisite Declaration

```
## Prerequisites

This handbook assumes you already know:

### Required Knowledge
- [Concept 1]: [Brief description] — If unfamiliar, read [Resource]
- [Concept 2]: [Brief description] — If unfamiliar, read [Resource]
- [Tool/Language]: [Skill level required] — [Install/setup link]

### Helpful Background (not required)
- [Concept]: [How it helps but is not blocking]

### Hardware/Software Requirements
- [Specific version requirements]
- [Platform constraints]
```

### Chapter Dependency Graph

Before writing chapters, produce a dependency graph:

```
Chapter 1 (Fundamentals)
    └── Chapter 2 (Core Mechanics)
            ├── Chapter 3 (Implementation)
            │       └── Chapter 5 (Optimization)
            └── Chapter 4 (Integration)
                    └── Chapter 6 (Production Use)
Chapter 7 (Reference) — standalone, references all
```

This graph must be produced before writing begins. Violating chapter dependencies
(referencing Chapter 4 content inside Chapter 2) is a structural error.

---

## Phase 4: Chapter Sequencing

### Sequencing Principles

**Principle 1: Concepts before mechanisms.**
Explain why something exists before explaining how it works. A reader who understands
the motivation for a feature learns the implementation detail faster and retains it longer.

**Principle 2: Simple before complex.**
Introduce the simplest working version of every concept. Add complexity in subsequent
sections. Never begin with the complete, production-grade version.

**Principle 3: Concrete before abstract.**
Introduce every abstraction through a concrete example first. The abstraction is the
generalization of the concrete case, not a prerequisite to it.

**Principle 4: Breadth before depth at the chapter level, depth before breadth within sections.**
Give the reader a complete mental model of the chapter's scope in the Overview,
then go deep on each topic in turn.

**Principle 5: Pattern then variation.**
Teach the standard pattern. Then teach variations, edge cases, and alternatives.
Never teach all variations simultaneously.

### Standard Chapter Sequence for Handbooks

```
Chapter 0: Introduction & Prerequisites
Chapter 1: [Core concept 1] — simplest, most fundamental
Chapter 2: [Core concept 2] — builds directly on Ch. 1
Chapter 3: [Core concept 3] — extends or combines Ch. 1–2
...
Chapter N-2: [Advanced application]
Chapter N-1: [Integration / real-world project]
Chapter N:   [Reference / advanced topics / appendix]
```

---

## Phase 5: Handbook Chapter Template

Every chapter in a handbook uses this structure. It extends the Technical Book
Chapter template in DOCUMENTATION.md with educational apparatus.

```
Chapter N: [Title]

────────────────────────────────────────────────────────────
CHAPTER METADATA (internal planning — not published)
  Depends on:         [Chapter M, Section X]
  Required by:        [Chapter P]
  Estimated length:   [N words]
  Diagram count:      [N diagrams planned]
  Exercise count:     [N exercises]
  Key terms:          [term1, term2, term3]
────────────────────────────────────────────────────────────

1. Learning Objectives        (required — 3–6 bullet objectives)
2. Overview                   (required — 150–300 words, no definitions)
3. Prerequisites Reminder     (optional — 1–3 sentences pointing to dependencies)
4. Core Concepts              (required — main content, 800–2000 words)
   4a. Concept Explanation    (required — plain English first)
   4b. Intuition              (required — analogy or mental model)
   4c. Formal Definition      (required for technical handbooks)
   4d. Worked Example         (required — complete, annotated, tested)
5. Common Mistakes            (required — 3–7 mistakes with explanations)
6. Best Practices             (required — 3–7 practices with rationale)
7. Hands-On Exercises         (required — 3–10 graded exercises)
8. Mini Project               (recommended for intermediate+ handbooks)
9. Knowledge Check            (required — 5–10 self-test questions)
10. Chapter Summary           (required — 150–300 words)
11. Key Takeaways             (required — 5–10 bullet summary)
12. Cheat Sheet               (recommended — one-page reference card)
13. Glossary Entries          (required — all new terms defined this chapter)
14. Further Reading           (required — 3–10 annotated references)
```

---

## Worked Example Standards

Worked examples are the most important part of an educational handbook.
Every worked example must be:

**Complete**: The reader can reproduce the example exactly. No omitted steps.

**Annotated**: Every non-obvious line of code or step has an inline comment or
numbered callout explaining what it does and why.

**Progressive**: If multiple examples appear in a section, each example builds on
the previous. The last example in a chapter should integrate multiple concepts.

**Tested**: Code examples must produce the stated output when run in the stated environment.

### Worked Example Template

```
### Example N.M: [Descriptive Title]

**Goal**: [What this example demonstrates — one sentence]
**Setup**: [Environment, library versions, file structure — if needed]

[Narrative introducing the problem the example solves]

```[language]
[Complete, runnable code or step-by-step procedure]
```

**Output**:
```
[Exact output, or representative output for non-deterministic cases]
```

**Explanation**:
- Line N: [What this line does and why]
- Lines N–M: [What this block does]
- [Key decision]: [Why this approach was chosen over alternatives]

**Variations**: [Optional — how to modify for different cases]
```

---

## Exercises

Exercises are graded by type and difficulty. Every chapter needs a balanced mix.

### Exercise Types

| Type | Description | When to Use |
|---|---|---|
| Recall | "What is X?" / "Name the three Y." | Beginner chapters, after definitions |
| Comprehension | "Explain why X causes Y." | After conceptual sections |
| Application | "Implement X given Y." | After implementation sections |
| Analysis | "Compare X and Y. When would you choose each?" | Intermediate+ |
| Debugging | "Find the error in this code." | After worked examples |
| Extension | "Modify the example to also handle Z." | After complete examples |
| Design | "Design a system that satisfies requirements R." | Advanced chapters |
| Research | "Find the official specification for X and summarize." | All levels |

### Exercise Format

```
### Exercise N.M: [Title] ⭐ / ⭐⭐ / ⭐⭐⭐

**Difficulty**: [Beginner / Intermediate / Advanced]
**Estimated time**: [N minutes]
**Topics tested**: [list of concepts]

[Problem statement — clear, unambiguous, self-contained]

**Hints** (optional):
1. [Hint 1]
2. [Hint 2]

**Expected output** (for coding exercises):
```
[Output]
```

**Solution**: See Appendix [N], Exercise [M]. [Or: "Solution in solutions/ directory."]
```

---

## Knowledge Checks

A knowledge check is a self-test at the end of a chapter. It is shorter than the
exercise set and confirmatory rather than challenging. Use it to test that the reader
absorbed the chapter's core content.

### Knowledge Check Template

```
## Knowledge Check

Answer these questions before proceeding. Answers in Appendix [N].

1. [Multiple choice or short answer — recall level]
   a) [Option]
   b) [Option]
   c) [Option]
   d) [Option]

2. [True/False with explanation required]

3. [Fill in the blank]

4. [Short explanation — 2–3 sentences]

5. [Apply: given [scenario], what would you do?]
```

---

## Key Takeaways

Every chapter ends with a "Key Takeaways" section — a scannable list of the 5–10 most
important points from the chapter.

### Key Takeaways Rules

- Write as complete sentences, not fragments
- Each takeaway must be self-contained (understandable without reading the chapter)
- Do not introduce new concepts in the takeaways
- Order from most to least fundamental
- Maximum one takeaway per major section of the chapter

### Key Takeaways Template

```
## Key Takeaways

- [Most fundamental insight from the chapter]
- [Second most important concept]
- [Critical rule or constraint readers must remember]
- [Common mistake to avoid]
- [Best practice to follow]
- [Pointer to related concept in another chapter]
```

---

## Cheat Sheets

A cheat sheet is a one- or two-page condensed reference for the chapter's content.
Include a cheat sheet in any chapter where the reader will regularly need to look
up syntax, commands, formulas, or rules.

### Cheat Sheet Contents

Include in a cheat sheet:
- Syntax reference for all commands/functions introduced
- Key formulas (with brief labels, not derivations)
- Decision table: "When to use X vs Y"
- Common patterns with one-line explanations
- Error reference: top 3 errors and their fixes
- Quick configuration reference (if applicable)

Format as a table or two-column layout suitable for printing.

---

## Glossary

Every handbook must maintain a cumulative glossary. Glossary entries are collected
from every chapter and presented alphabetically in the appendix.

### Glossary Entry Format

```
**[Term]** *(noun/verb/adj)* — [Definition in one to three sentences. Include the
first chapter where this term appears in parentheses: (Chapter N).]*
```

Rules:
- Define every technical term introduced in the handbook
- Do not define terms the audience already knows (per the audience profile)
- Link every use of a glossary term back to its definition on first chapter use
- Update the glossary whenever a new term is introduced

---

## Appendix Structure

Handbooks commonly require these appendices:

| Appendix | Contents | Required? |
|---|---|---|
| A: Solutions | Full solutions to all exercises | Recommended for self-study |
| B: Glossary | Cumulative term definitions | Required |
| C: Further Reading | Annotated bibliography organized by chapter | Required |
| D: Cheat Sheets | Collected cheat sheets from all chapters | Recommended |
| E: Reference Tables | Quick-reference tables, formulas, config options | Optional |
| F: Installation Guide | Environment setup for all examples | Required if env setup is non-trivial |
| G: Index | Alphabetical subject index with page numbers | Required for print |

---

## Index Generation

A handbook index is a structured map of topics to page or section numbers.
The index differs from the glossary: the glossary defines terms; the index locates topics.

### Indexing Rules

Index every occurrence of:
- All glossary terms
- Named algorithms and data structures
- Named configuration options, flags, and parameters
- Function and method names (for technical handbooks)
- Error messages and codes
- Proper nouns (tools, languages, specifications)

Do not index:
- Incidental mentions that add no information
- Preface and introduction material

---

## Supporting Material Summary

For every handbook, evaluate whether these materials should be generated:

| Material | Required | When |
|---|---|---|
| Solutions appendix | Recommended | When exercises are non-trivial |
| Glossary | Required | Always |
| Index | Required | Print or long handbooks |
| Cheat sheets per chapter | Recommended | When the chapter has memorizable syntax |
| Mini projects | Recommended | Intermediate and advanced handbooks |
| Knowledge check Q&A | Required | Always |
| Annotated bibliography | Required | Always |
| Setup/installation guide | Required | When the reader must install software |
| Quick start guide | Optional | Long handbooks with impatient readers |
| FAQ | Optional | Topics with known common confusions |

---

## Checklist

Before delivering a handbook:

- [ ] Global learning objectives written and measurable
- [ ] Audience profile defined and calibration applied throughout
- [ ] All prerequisite knowledge identified and external resources linked
- [ ] Chapter dependency graph produced and respected
- [ ] Every chapter has: objectives, overview, core concepts, examples, exercises, summary, takeaways
- [ ] All worked examples are complete, annotated, and tested
- [ ] Exercise types are varied (recall, application, design, debugging)
- [ ] Knowledge check present at end of every chapter
- [ ] Key Takeaways are complete sentences, self-contained, and accurate
- [ ] Cheat sheets present for all syntax-heavy chapters
- [ ] Glossary entries collected from all chapters
- [ ] Appendix structure defined
- [ ] Supporting material evaluated (solutions, FAQ, quick start)

---

## Related Modules

- **CURRICULUM.md** — Prerequisite for this module in educational workflows. Load first.
- **CHAPTER_PLAN.md** — Chapter-level planning before writing begins.
- **PUBLICATION_TYPES.md** — Select the correct publication type before choosing this module.
- **VISUAL_PLANNER.md** — Diagram planning for each chapter.
- **DOCUMENTATION.md** — Base chapter templates extended by this module.
- **QUALITY.md** — QA checklist includes handbook-specific checks.
- **SUPPORTING_MATERIAL.md** — Automated evaluation of supplementary content.

---

## Version

```
Module:    HANDBOOK.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Extends:   DOCUMENTATION.md
```
