# DOCUMENTATION.md — Core Authoring System

## Purpose

This is the structural core of the documentation skill. It defines how chapters are
organized, what sections every chapter must contain, how content within sections is
written, and how the document as a whole is assembled from its parts.

This file does not define style (see STYLE_GUIDE.md), diagram rules (see DIAGRAMS.md),
or compilation (see LATEX.md). It defines structure and content completeness.

## When to Use This File

Load this file after completing the research phase (RESEARCH.md). Use it to:

1. Produce the document outline before writing any prose.
2. Populate each chapter section in the correct order.
3. Verify that no required section is missing before declaring a chapter complete.
4. Understand how chapters relate to each other at the book level.

## Document Types and Their Templates

This skill supports nine document types. Each has a different chapter structure.
Select the template that matches the task.

| Document Type | Template | Use When |
|---|---|---|
| Technical Book | Book Template | Multi-chapter comprehensive reference |
| API Documentation | API Template | Documenting a REST, gRPC, or library API |
| SDK Documentation | SDK Template | Documenting a language-specific SDK |
| RFC-Style Specification | RFC Template | Formal protocol or format specification |
| Architecture Handbook | Architecture Template | System design and architecture decisions |
| Whitepaper | Whitepaper Template | Persuasive technical position document |
| Tutorial Series | Tutorial Template | Step-by-step learning sequence |
| Research Paper | Paper Template | Academic-style investigation |
| Design Document | Design Template | Proposal for a new system or feature |

---

## Template 1: Technical Book Chapter

Every chapter in a technical book must contain these sections in this order.
Do not omit sections. If a section genuinely does not apply, write one sentence
explaining why it is not applicable rather than deleting the section.

```
Chapter N: [Title]

1. Overview               (required, 150–300 words)
2. Motivation             (required, 200–400 words)
3. Background             (optional, 200–500 words — prerequisites)
4. Core Concepts          (required, 500–1500 words)
5. Architecture           (required if system has components)
6. Implementation         (required, 500–2000 words)
7. Examples               (required, 2–5 worked examples)
8. Common Mistakes        (required, 3–7 items)
9. Best Practices         (required, 3–7 items)
10. Performance           (required if performance-relevant)
11. Security              (required if security-relevant)
12. Mini Project          (optional — reinforces learning)
13. Exercises             (required, 3–10 exercises)
14. Summary               (required, 150–300 words)
15. Further Reading       (required, 3–10 references)
```

### Section 1: Overview (150–300 words)

States what the chapter covers and why it matters to the reader. Must answer:
- What is the topic?
- Why does it matter?
- What will the reader be able to do after this chapter?

Does not define terms. Does not list contents. Motivates the reader to continue.

**Template**:
```
[Chapter title] is [definition in one sentence]. [Why it matters — concrete consequence
for the reader]. This chapter covers [4–6 key topics], providing the conceptual
foundations and practical skills needed to [specific capability the reader gains].

By the end of this chapter, you will be able to:

- [Skill 1]
- [Skill 2]
- [Skill 3]
```

### Section 2: Motivation (200–400 words)

Presents the problem that this chapter's content solves. Must include:
- A concrete scenario where the problem manifests
- The consequences of not having the solution
- A before/after comparison (prose or code)

Do not begin with the solution. Begin with the problem.

**Template**:
```
Consider [concrete scenario]. In this scenario, [specific challenge arises]. Without
[concept being introduced], [negative consequence]. [Quantify the consequence if
possible: "This results in X% increase in latency" or "This forces re-downloading Y GB"].

[Expand the motivation with a second scenario or a more general statement of the problem].

[Concept being introduced] solves this problem by [brief description of the mechanism].
The rest of this chapter explains how.
```

### Section 3: Background (200–500 words, optional)

Lists and briefly explains prerequisites. Use only if the chapter builds on concepts
not previously defined in the book. Cross-reference to earlier chapters.

Format:
```
This chapter assumes familiarity with the following concepts. If any of these are
unfamiliar, the indicated chapter provides the necessary background.

- **[Concept A]**: [One-sentence definition]. (Chapter N)
- **[Concept B]**: [One-sentence definition]. (Chapter M)
```

### Section 4: Core Concepts (500–1500 words)

The intellectual heart of the chapter. Defines and explains every major concept,
term, and idea introduced in this chapter.

Rules:
- Define every term at first use with a full sentence definition.
- Follow every abstract concept with a concrete example or analogy.
- Use diagrams for concepts that have spatial, temporal, or structural character.
  (See DIAGRAMS.md for diagram selection guidance.)
- Build from simple to complex. Do not introduce a complex form before the simple form.

Structure within Core Concepts (adapt as needed):
```
4.1 [First fundamental concept]
  - Definition
  - Motivation/why this exists
  - Concrete example
  - Diagram (if applicable)

4.2 [Second fundamental concept]
  ...

4.3 [Relationship between concepts]
  ...
```

### Section 5: Architecture (variable, required for systems chapters)

Describes the structural organization of the system, protocol, or framework being
documented. Must include at minimum one architecture diagram.

Required subsections:
```
5.1 Component overview   (what the parts are)
5.2 Data flow            (how information moves through the system)
5.3 Interfaces           (how components communicate)
5.4 State management     (how state is held and modified)
```

Every architecture section must reference a diagram. See DIAGRAMS.md.

### Section 6: Implementation (500–2000 words)

Shows how the concepts are applied in practice. This section contains code.
Every code listing must:
- Have a caption (Listing N.M: Description)
- Specify the language
- Be syntactically correct and tested
- Be explained in the prose immediately before and after

Structure:
```
6.1 Basic implementation  (minimal working example)
6.2 Configuration         (how to configure behavior)
6.3 Error handling        (how to handle failures)
6.4 Advanced usage        (extension points, performance tuning)
```

### Section 7: Examples (2–5 worked examples)

Worked examples are different from code listings in Section 6. They are end-to-end
scenarios that integrate multiple concepts from the chapter.

Each example follows this format:
```
### Example N.M: [Scenario title]

**Problem**: [One-paragraph statement of what we want to accomplish]

**Setup**: [Environment, dependencies, initial state]

**Solution**:
[Listing N.M: Code]

**Walkthrough**: [Step-by-step explanation of how the solution works]

**Result**: [What the reader should observe]

**Variations**: [How to adapt this example for different requirements]
```

### Section 8: Common Mistakes (3–7 items)

Documents the most frequent errors made by practitioners using this technology.
Sourced from: official issue trackers, StackOverflow analysis, personal experience
documentation, and security advisories.

Each mistake follows this format:
```
#### Mistake N: [Short name]

**What happens**: [What the incorrect usage looks like]
**Why it is wrong**: [The underlying reason]
**How to detect it**: [Symptoms, error messages, or test failures]
**The correct approach**: [What to do instead]
```

### Section 9: Best Practices (3–7 items)

Documents the practices that experienced practitioners consistently apply. These
are positive recommendations (not corrections of mistakes — that is Section 8).

Each practice follows this format:
```
#### Practice N: [Short name]

**The practice**: [What to do]
**Why it matters**: [The consequence of not following it]
**How to apply it**: [Concrete action or checklist]
**Example**: [Brief code or configuration example]
```

### Section 10: Performance (when applicable)

Covers performance characteristics, tuning knobs, and benchmarking guidance.

Required content:
- Complexity analysis (time and space) if algorithmic
- Known bottlenecks and their causes
- Tuning parameters with their effects
- Benchmark methodology (how to measure, not just what the numbers are)
- At least one performance table (see TABLES.md for benchmark table format)

Do not include benchmark numbers without specifying the hardware, version, and
methodology. Numbers without context are marketing, not documentation.

### Section 11: Security (when applicable)

Covers security properties, threat model, known vulnerabilities, and hardening.

Required content:
- Threat model: what threats this technology defends against and which it does not
- Known vulnerability classes (e.g., injection, authentication bypass, SSRF)
- Hardening checklist
- CVE references if applicable

Do not claim a system is "secure" without specifying against what threat model.

### Section 12: Mini Project (optional)

A self-contained project that integrates the chapter's concepts into a working artifact.
Suitable for textbooks and tutorial series. Not typical for reference documentation.

Format:
```
### Mini Project: [Project name]

**Goal**: [What the project builds]
**Requirements**: [Explicit list of what the reader must have installed/configured]
**Step-by-step instructions**: [Numbered steps]
**Expected output**: [What success looks like]
**Extension challenges**: [Optional harder variants]
```

### Section 13: Exercises (3–10 exercises)

Exercises test the reader's understanding at multiple levels.

Label each exercise with a difficulty:
- 🔵 **Conceptual**: Tests understanding of definitions and principles (no coding)
- 🟡 **Applied**: Requires writing or modifying code
- 🔴 **Advanced**: Open-ended or research-level challenge

Format:
```
**Exercise N.M** (🔵 Conceptual)

[Question or task]

*Hint*: [Optional hint for harder exercises]
```

Do not provide answers in the chapter body. Answers go in an appendix.

### Section 14: Summary (150–300 words)

Synthesizes the chapter. Does not introduce new information. Answers:
- What did we learn?
- How do the concepts connect?
- What should the reader remember above all else?

Every summary must name the three to five most important concepts from the chapter.

### Section 15: Further Reading (3–10 references)

See STYLE_GUIDE.md for format. Required subcategories:
- Foundational papers (when applicable)
- Official documentation
- Books
- (Optional) Talks and videos from recognized experts

---

## Template 2: API Documentation

API documentation covers one API endpoint, function, class, or module per entry.

```
[METHOD] /path/to/endpoint

Brief description (one sentence).

AUTHENTICATION
  Required: [none | API key | OAuth 2.0 | JWT]
  Header: [header name and format]

REQUEST
  Path Parameters:
    name (type, required): Description.

  Query Parameters:
    name (type, optional, default=X): Description.

  Request Body (application/json):
    {
      "field": type  // Description. Constraints.
    }

RESPONSE
  200 OK:
    {
      "field": type  // Description.
    }

  400 Bad Request:
    { "error": "message" }  // When this occurs.

  401 Unauthorized:
    When authentication is missing or invalid.

  429 Too Many Requests:
    Rate limit: X requests per Y seconds.

EXAMPLE REQUEST
  curl -X POST https://api.example.com/v1/endpoint \
    -H "Authorization: Bearer {token}" \
    -H "Content-Type: application/json" \
    -d '{"field": "value"}'

EXAMPLE RESPONSE
  { "id": "abc123", "status": "created" }

NOTES
  - [Important behavioral note]
  - [Rate limiting or quota note]

CHANGELOG
  v2.0: [Breaking change description]
  v1.3: [Feature addition]
```

---

## Template 3: RFC-Style Specification

Follows RFC 2223 and related formatting conventions.

```
[Document Title]                                          [Author(s)]
[Working Group / Organization]                            [Date]
[Category: Standards Track | Informational | Experimental]

Abstract

   [150–250 words. States the problem and what this document specifies.
   Does not motivate. Does not explain history. States facts only.]

Status of This Memo

   [Standard RFC status boilerplate]

Table of Contents

   1. Introduction ............................................ X
   2. Requirements Notation .................................. X
   3. Definitions ............................................ X
   4. [Core specification sections] ......................... X
   N. Security Considerations ................................ X
   N+1. IANA Considerations .................................. X
   N+2. References ........................................... X

1. Introduction

   [Background and motivation. Problem statement. Scope.]

2. Requirements Notation

   The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
   "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
   document are to be interpreted as described in RFC 2119 [RFC2119].

3. Definitions

   [Precise definitions of all terms used normatively in this document.]

...

Security Considerations

   [Every RFC MUST have this section. Describes the security properties
   the specification provides and explicitly states what it does NOT provide.]
```

---

## Template 4: Architecture Document

```
[System Name] Architecture

Authors: [names]
Status: [Draft | Under Review | Approved]
Date: [date]

1. Executive Summary (200–400 words)
2. Problem Statement
3. Goals and Non-Goals
4. Proposed Architecture
   4.1 System Context Diagram
   4.2 Component Diagram
   4.3 Data Flow
   4.4 API Contracts
   4.5 Data Model
5. Alternatives Considered
   [For each alternative: description, why rejected]
6. Risks and Mitigations
7. Implementation Plan
8. Open Questions
9. References
```

---

## Document Assembly (Book Level)

A complete technical book assembled using this skill has this structure:

```
Front Matter
  Half title page
  Full title page
  Copyright and colophon
  Dedication (optional)
  Table of contents
  List of figures
  List of tables
  List of listings
  Preface
  Acknowledgments (optional)

Main Text
  Part I: [Title]          (optional — groups chapters thematically)
    Chapter 1: Introduction
    Chapter 2: [Topic]
    ...
  Part II: [Title]
    Chapter N: [Topic]
    ...

Back Matter
  Appendix A: [Reference material too detailed for chapters]
  Appendix B: [Exercise answers]
  Appendix C: [Quick reference / cheat sheet]
  Glossary
  Bibliography
  Index
```

Every component of the front matter and back matter has a template in the
`templates/` directory of this skill.

## Inter-file Relationships

```
DOCUMENTATION.md
    ├── SYSTEM.md        (all structure decisions are consistent with SYSTEM.md rules)
    ├── STYLE_GUIDE.md   (all prose follows STYLE_GUIDE.md)
    ├── RESEARCH.md      (research must complete before authoring begins)
    ├── CODE.md          (Section 6 and 7 use CODE.md for all listings)
    ├── DIAGRAMS.md      (Section 5 uses DIAGRAMS.md for architecture diagrams)
    ├── TABLES.md        (Sections 10 and elsewhere use TABLES.md)
    ├── FIGURES.md       (all figures in all sections use FIGURES.md)
    ├── CITATIONS.md     (Section 15 and all inline citations use CITATIONS.md)
    └── QUALITY.md       (verifies all sections are complete and meet standards)
```

---

## Extended Document Type Support (v2.0)

The following document types are now supported in addition to the nine templates above.
For full module loading sequences for each type, see PUBLICATION_TYPES.md.

### Educational Publications

For handbooks, courses, tutorials, workshops, and lab manuals, DOCUMENTATION.md is
extended by HANDBOOK.md. The HANDBOOK.md chapter template adds:

- Learning objectives (required)
- Prerequisites reminder (optional)
- Intuition and analogy sections (required for beginner/intermediate)
- Knowledge check (required)
- Key takeaways (required)
- Cheat sheet (recommended)
- Glossary entries (required)

Load HANDBOOK.md after this module for educational publications.
Run CURRICULUM.md and CHAPTER_PLAN.md before writing any educational chapter.

### Operations and User Manuals

Operations manuals and user manuals use a procedure-first structure:

```
Section N: [Operation Name]

1. Prerequisites       (required — what must be in place before starting)
2. Procedure          (required — numbered steps)
3. Expected Output    (required — what success looks like)
4. Verification       (required — how to confirm success)
5. Troubleshooting    (required — top 3 failure modes and fixes)
6. Rollback           (required if the operation is reversible)
```

Every step in a procedure must be:
- A single action (not "install and configure X")
- Followed by its expected output
- Followed by how to verify the step succeeded

### Troubleshooting Guides

Troubleshooting guides use a symptom-first structure:

```
## [Symptom Description]

**Symptom**: [Exact observable behavior — error message, unexpected output, etc.]
**Cause(s)**:
  - Primary: [Most common cause]
  - Secondary: [Less common cause]
**Resolution**:
  1. [First step]
  2. [Second step]
**Verification**: [How to confirm the problem is resolved]
**Prevention**: [How to avoid this in future]
**Related Issues**: [Links to related symptoms]
```

Organize troubleshooting guides with a decision tree (see VISUAL_PLANNER.md) so
readers can navigate to their symptom quickly.

### Knowledge Base Articles

Knowledge base articles answer one question per article.

```
Title: [Answer the question directly in the title — "How to configure X", "Why Y fails"]

**Summary**: [Answer in 1–2 sentences. Put the answer first.]

## Background (optional)
[Context if needed — keep brief]

## Steps / Solution
[Numbered steps or explanation]

## Related Articles
- [Link to related article]
- [Link to related article]

**Last verified**: [Date and version]
```

---

## Updated Inter-file Relationships

```
DOCUMENTATION.md
    ├── SYSTEM.md               (structure decisions consistent with SYSTEM.md)
    ├── STYLE_GUIDE.md          (all prose follows STYLE_GUIDE.md)
    ├── RESEARCH.md             (research completes before authoring)
    ├── CODE.md                 (all code listings)
    ├── DIAGRAMS.md             (all diagrams)
    ├── TABLES.md               (all tables)
    ├── FIGURES.md              (all figures)
    ├── CITATIONS.md            (all citations)
    ├── QUALITY.md              (verifies all sections complete)
    ├── HANDBOOK.md             (NEW: extends for educational publications)
    ├── CURRICULUM.md           (NEW: prerequisite for educational chapters)
    ├── CHAPTER_PLAN.md         (NEW: per-chapter planning before writing)
    ├── VISUAL_PLANNER.md       (NEW: diagram planning before writing)
    ├── PUBLICATION_TYPES.md    (NEW: determines which template to use)
    └── SUPPORTING_MATERIAL.md  (NEW: back matter generation)
```
