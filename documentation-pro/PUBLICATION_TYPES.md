# PUBLICATION_TYPES.md — Publication Type Catalog

## Purpose

This module defines every supported publication type, its characteristics,
the correct module loading sequence, and its template. Select a publication
type before beginning any documentation task.

Selecting the wrong publication type causes structural misalignment:
an API reference written as a handbook wastes space with pedagogical apparatus;
a handbook written as a reference omits learning scaffolding readers need.

## When to Load

Load this module first, immediately after SKILL.md. Identify the publication type.
Then load the module sequence specified for that type.

## When NOT to Load

Never skip this module. Publication type selection is mandatory.

---

## Publication Type Index

| # | Publication Type | Primary Audience | Learning Intent |
|---|---|---|---|
| 1 | Technical Handbook | Students, practitioners learning a domain | High |
| 2 | Developer Guide | Software developers | Moderate |
| 3 | Operations Manual | Ops engineers, SREs | Low |
| 4 | User Manual | End users (non-technical) | Moderate |
| 5 | Installation Guide | Technical users | Low |
| 6 | Architecture Guide | Senior engineers, architects | Low |
| 7 | Design Document | Internal technical team | Low |
| 8 | Research Report | Technical stakeholders | Moderate |
| 9 | Whitepaper | Decision-makers, technical leaders | Moderate |
| 10 | Tutorial | Practitioners learning a task | High |
| 11 | Course Material | Students in structured program | High |
| 12 | Workshop Notes | Participants in hands-on session | High |
| 13 | Lab Manual | Students in practical session | High |
| 14 | Knowledge Base | Support, operations, internal | Low |
| 15 | Reference Manual | Practitioners needing lookup | Low |
| 16 | CLI Documentation | Developers using CLI tools | Low |
| 17 | API Reference | Developers integrating APIs | Low |
| 18 | SDK Guide | Developers using a library | Moderate |
| 19 | RFC / Specification | Protocol implementers | Low |
| 20 | Standards Document | Compliance, implementation | Low |
| 21 | Best Practices Guide | Practitioners | Moderate |
| 22 | Migration Guide | Practitioners upgrading | Low |
| 23 | Troubleshooting Guide | Support, practitioners | Low |
| 24 | Internal Documentation | Team members | Low |

---

## Type 1: Technical Handbook

**Definition**: A complete educational resource teaching a domain progressively.
The reader begins with no assumed domain knowledge (or minimal) and finishes
with the ability to work effectively in the domain.

**Characteristics**:
- 10–25 chapters, 50,000–300,000 words
- Learning objectives at book and chapter level
- Worked examples in every chapter
- Exercises, knowledge checks, cheat sheets
- Glossary, index, appendices
- Progressive difficulty: beginner → intermediate → advanced

**Examples**: *The Linux Command Line* (Shotts), *Operating Systems: Three Easy Pieces* (Arpaci-Dusseau), *Designing Data-Intensive Applications* (Kleppmann)

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
CURRICULUM.md → CHAPTER_PLAN.md → VISUAL_PLANNER.md →
HANDBOOK.md → DOCUMENTATION.md → DIAGRAMS.md → TABLES.md →
FIGURES.md → CODE.md → CITATIONS.md → LATEX.md →
BUILD.md → QUALITY.md → EXPORT.md → SUPPORTING_MATERIAL.md
```

**Templates**: `templates/book.tex`, `templates/chapter.tex`

---

## Type 2: Developer Guide

**Definition**: Documentation that teaches developers how to use a product, platform,
or framework to build their own applications. Oriented around tasks and use cases
rather than exhaustive reference.

**Characteristics**:
- Task-oriented sections
- Getting Started section (required)
- Conceptual explanations of key abstractions
- Code examples for every task
- Links to API reference for detail
- Troubleshooting section

**Examples**: GitHub API Developer Guide, Stripe documentation, Twilio documentation

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → CODE.md → TABLES.md → DIAGRAMS.md →
VISUAL_PLANNER.md → CITATIONS.md → QUALITY.md → EXPORT.md
```

**Templates**: `templates/api-doc.md`

---

## Type 3: Operations Manual

**Definition**: Documentation for running, maintaining, and troubleshooting a system.
Audience: operations engineers who need to act, not learn.

**Characteristics**:
- Procedure-first structure
- Numbered steps for every operation
- Expected output after each step
- Error codes and recovery procedures
- Runbooks (step-by-step response to incidents)
- Configuration reference

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → TABLES.md → CODE.md → QUALITY.md → EXPORT.md
```

---

## Type 4: User Manual

**Definition**: Documentation for end users (non-technical) to operate software
or physical products. Assumes no technical background.

**Characteristics**:
- Task-based organization
- Plain language (no jargon without definition)
- Heavy use of screenshots and annotated images
- Step-by-step procedures
- FAQ section
- Glossary for any technical terms used

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → FIGURES.md → TABLES.md → QUALITY.md → EXPORT.md
```

---

## Type 5: Installation Guide

**Definition**: Documentation for installing, configuring, and initially setting up
software, hardware, or a system.

**Characteristics**:
- Platform-specific sections (Linux/macOS/Windows)
- Exact version requirements
- Verification steps after each major operation
- Troubleshooting section for common installation failures
- Short (1,000–10,000 words)

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → CODE.md → QUALITY.md → EXPORT.md
```

---

## Type 6: Architecture Guide

**Definition**: Documentation of a system's design decisions, component structure,
data flows, and engineering rationale. Audience: engineers who will build, extend,
or maintain the system.

**Characteristics**:
- Architecture diagrams (required, not optional)
- Decision rationale (why this design over alternatives)
- Trade-off analysis
- Component responsibilities and interfaces
- Data flow and sequence diagrams
- Evolutionary notes (what has changed and why)

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → DIAGRAMS.md → VISUAL_PLANNER.md → FIGURES.md →
TABLES.md → CITATIONS.md → QUALITY.md → EXPORT.md
```

**Templates**: `templates/rfc-whitepaper-architecture.md` (architecture section)

---

## Type 7: Design Document

**Definition**: A proposal for a new system, feature, or change. Used internally
to communicate design intent and gather feedback before implementation.

**Characteristics**:
- Problem statement
- Proposed solution
- Alternatives considered and rejected (with rationale)
- Implementation plan
- Risk analysis
- Open questions
- Review and approval section

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → DIAGRAMS.md → TABLES.md → QUALITY.md
```

---

## Type 8: Research Report

**Definition**: A technical investigation into a question, problem, or hypothesis.
Presents methodology, findings, and conclusions.

**Characteristics**:
- Abstract + executive summary
- Methodology section
- Data presentation (tables, charts)
- Analysis and interpretation
- Limitations section
- Conclusions and recommendations
- Bibliography

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → TABLES.md → FIGURES.md → DIAGRAMS.md →
CITATIONS.md → LATEX.md → BUILD.md → QUALITY.md → EXPORT.md
```

---

## Type 9: Whitepaper

**Definition**: A persuasive technical document arguing for a position, technology,
or approach. Audience: technical decision-makers.

**Characteristics**:
- Executive summary
- Problem framing
- Proposed approach
- Evidence and analysis
- Business case (optional)
- Conclusion with call to action
- 5–30 pages

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → FIGURES.md → TABLES.md → CITATIONS.md →
QUALITY.md → EXPORT.md
```

**Templates**: `templates/rfc-whitepaper-architecture.md` (whitepaper section)

---

## Type 10: Tutorial

**Definition**: A learning-by-doing document that guides the reader through
building or accomplishing a specific thing. Outcome-focused.

**Characteristics**:
- Single concrete outcome ("By the end, you will have built X")
- Step-by-step, no assumptions skipped
- Every step has expected output
- Common errors and how to fix them
- 500–5,000 words
- Code examples tested in the stated environment

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
HANDBOOK.md → DOCUMENTATION.md → CODE.md → QUALITY.md → EXPORT.md
```

---

## Type 11: Course Material

**Definition**: Complete material for a structured learning course — lectures,
labs, assignments, quizzes. May span multiple sessions.

**Characteristics**:
- Session/module structure
- Learning objectives per session
- Lecture content + speaking notes
- Lab exercises with solutions
- Assessment questions
- Grading rubrics

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
CURRICULUM.md → CHAPTER_PLAN.md → HANDBOOK.md →
DOCUMENTATION.md → CODE.md → DIAGRAMS.md → VISUAL_PLANNER.md →
QUALITY.md → SUPPORTING_MATERIAL.md → EXPORT.md
```

---

## Type 12: Workshop Notes

**Definition**: Material for an interactive workshop — shorter than a course,
hands-on throughout.

**Characteristics**:
- 2–8 hours content
- Alternating presentation + exercise structure
- Exercises runnable in the workshop environment
- Facilitator notes (separate from participant notes)
- Take-home resources

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
HANDBOOK.md → DOCUMENTATION.md → CODE.md → QUALITY.md → EXPORT.md
```

---

## Type 13: Lab Manual

**Definition**: Instructions for hands-on laboratory exercises. Audience:
students performing practical work.

**Characteristics**:
- Safety / setup requirements
- Objective per lab
- Step-by-step procedure
- Data recording templates
- Analysis questions
- Report template

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
HANDBOOK.md → DOCUMENTATION.md → FIGURES.md → TABLES.md →
CODE.md → QUALITY.md → EXPORT.md
```

---

## Type 14: Knowledge Base

**Definition**: A searchable collection of articles answering specific questions.
Not read linearly — each article is self-contained.

**Characteristics**:
- Every article answers one question
- Short (200–1,000 words per article)
- Interlinked (related articles cross-reference)
- Tag/category indexed
- Search-optimized titles

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → CODE.md → QUALITY.md → EXPORT.md
```

---

## Type 15: Reference Manual

**Definition**: Exhaustive documentation of every option, parameter, function,
or command in a system. Audience: practitioners who know the system and need to
look up specifics.

**Characteristics**:
- Alphabetical or categorical organization
- Every item fully documented
- No progressive learning structure
- Dense format
- Comprehensive tables

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → TABLES.md → CODE.md → QUALITY.md → EXPORT.md
```

---

## Type 16: CLI Documentation

**Definition**: Documentation for command-line tools — commands, flags, subcommands,
configuration files.

**Characteristics**:
- Command reference (every command, subcommand, flag)
- Examples for common use cases
- Configuration file reference
- Exit codes
- Environment variables

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → CODE.md → TABLES.md → QUALITY.md → EXPORT.md
```

---

## Type 17: API Reference

**Definition**: Complete documentation of every API endpoint, method, parameter,
and response. See DOCUMENTATION.md Template 2.

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → TABLES.md → CODE.md → QUALITY.md → EXPORT.md
```

**Templates**: `templates/api-doc.md`

---

## Type 18: SDK Guide

**Definition**: Documentation for a language-specific library or SDK.
Combines reference (every class and method) with usage patterns.

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → CODE.md → TABLES.md → DIAGRAMS.md →
QUALITY.md → EXPORT.md
```

---

## Type 19: RFC / Specification

**Definition**: A formal specification of a protocol, format, or interface.
See DOCUMENTATION.md Template 4. Normative language (MUST, SHOULD, MAY) per RFC 2119.

**Module Loading Sequence**:
```
SKILL.md → SYSTEM.md → STYLE_GUIDE.md → RESEARCH.md →
DOCUMENTATION.md → TABLES.md → DIAGRAMS.md → CITATIONS.md →
QUALITY.md → EXPORT.md
```

**Templates**: `templates/rfc-whitepaper-architecture.md` (RFC section)

---

## Type 20–24: Abbreviated Entries

**Standards Document (20)**: Formal definition of a standard. MUST/SHOULD/MAY language.
Conformance levels. Test cases. Similar loading sequence to RFC.

**Best Practices Guide (21)**: Recommendations backed by rationale. Organized by topic.
Pro/con tables. Load: DOCUMENTATION.md + TABLES.md + CITATIONS.md.

**Migration Guide (22)**: Step-by-step guide for upgrading from version X to Y.
Breaking changes highlighted. Before/after code comparisons. Load: DOCUMENTATION.md + CODE.md.

**Troubleshooting Guide (23)**: Symptom → cause → solution structure. Decision trees.
Error code index. Load: DOCUMENTATION.md + DIAGRAMS.md (decision trees) + TABLES.md.

**Internal Documentation (24)**: Team wikis, runbooks, onboarding docs. Informal tone permitted.
Load: SYSTEM.md + DOCUMENTATION.md + CODE.md.

---

## Publication Type Selection Checklist

```
PUBLICATION TYPE SELECTION
──────────────────────────────────────────────────────────────
Task description: [Describe the documentation task in 1–3 sentences]

Q1: Is the reader expected to build knowledge progressively?
    Yes → Educational type (1, 10, 11, 12, 13)
    No  → Reference type (3, 4, 5, 14, 15, 16, 17, 18)

Q2: Does the document make an argument or recommendation?
    Yes → Persuasive type (9 Whitepaper, 21 Best Practices, 7 Design Doc)
    No  → Continue

Q3: Is this a formal protocol or standard?
    Yes → Type 19 (RFC) or Type 20 (Standards)
    No  → Continue

Q4: Is this API/SDK documentation?
    Yes → Type 17 (API Reference) or Type 18 (SDK Guide)
    No  → Continue

Q5: Is this about running/maintaining an existing system?
    Yes → Type 3 (Operations) or Type 23 (Troubleshooting)
    No  → Continue

Q6: Does it cover a complete domain over 10+ chapters?
    Yes → Type 1 (Technical Handbook)
    No  → Select the closest match from the catalog

Selected type: [Type number and name]
Module sequence: [List from the selected type's section]
──────────────────────────────────────────────────────────────
```

---

## Related Modules

- **SKILL.md** — Load PUBLICATION_TYPES.md immediately after SKILL.md.
- **CURRICULUM.md** — Required for educational publication types (1, 10, 11, 12, 13).
- **HANDBOOK.md** — Required for Type 1.
- **DOCUMENTATION.md** — Provides templates for all types.
- **SUPPORTING_MATERIAL.md** — Evaluate supporting material after type is selected.

---

## Version

```
Module:    PUBLICATION_TYPES.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Position:  Load immediately after SKILL.md
```
