# PUBLICATION_BLUEPRINT.md — Publication Planning System

## Purpose

This module defines the mandatory pre-writing planning stage for every publication.
Before any research begins, the Documentation Agent must produce a Publication Blueprint
that defines the publication's audience, purpose, scope, structure, and deliverables.

A blueprint prevents scope creep, audience mismatch, and structural inconsistency.
It is the contract between the agent and the task.

## When to Load

Load immediately after PUBLICATION_TYPES.md. A blueprint must be approved before
research (RESEARCH.md) or writing (DOCUMENTATION.md, HANDBOOK.md) begins.

## When NOT to Load

Do not skip the blueprint for any substantive publication. For micro-documents
(cheat sheets, single reference articles under 1,000 words), use a simplified
version of the blueprint.

---

## Publication Blueprint Template

Complete every field. "TBD" is not acceptable for Required fields.

```
╔═══════════════════════════════════════════════════════════════════════╗
║                        PUBLICATION BLUEPRINT                          ║
╚═══════════════════════════════════════════════════════════════════════╝

IDENTITY
────────────────────────────────────────────────────────────────────────
Title:              [Working title — descriptive, not clever]
Subtitle:           [Optional clarifying subtitle]
Publication Type:   [Type number and name from PUBLICATION_TYPES.md]
Version:            [1.0 / draft / edition number]
Date:               [Target completion date]

AUDIENCE
────────────────────────────────────────────────────────────────────────
Primary Audience:   [Who will read this? Job title, role, or description]
Experience Level:   [ ] Beginner  [ ] Intermediate  [ ] Advanced  [ ] Expert
Domain Background:  [What does the reader already know about this domain?]
Technical Stack:    [Languages, tools, platforms the reader uses]
Reading Context:    [ ] Self-study  [ ] Reference  [ ] On-the-job  [ ] Classroom
Reader Goal:        [What does the reader want to accomplish after reading?]

Secondary Audience: [Optional — who else might read this?]

PURPOSE
────────────────────────────────────────────────────────────────────────
Primary Purpose:    [One sentence: what does this publication accomplish?]
Secondary Purposes: [Additional goals, e.g., "also serves as team reference"]

Success Criteria:   [How will we know this publication achieved its purpose?
                    Measurable if possible: "Reader can implement X without
                    additional resources."]

SCOPE
────────────────────────────────────────────────────────────────────────
In Scope:
  - [Topic A]
  - [Topic B]
  - [Topic C]

Out of Scope:
  - [Topic X — with reason: too advanced / covered elsewhere / not relevant]
  - [Topic Y — with reason]

Assumptions:
  - [What the publication assumes the reader already knows]
  - [Environment assumptions: OS, software version, access level]

SIZE
────────────────────────────────────────────────────────────────────────
Estimated Chapters:   [N chapters]
Estimated Length:     [~N words / ~N pages]
Target Reading Level: [Flesch-Kincaid grade level or description]
Estimated Read Time:  [N hours reading + N hours practice (if applicable)]

STRUCTURE
────────────────────────────────────────────────────────────────────────
Top-Level Structure:

  Chapter 0: [Title] — [Purpose in one sentence]
  Chapter 1: [Title] — [Purpose in one sentence]
  Chapter 2: [Title] — [Purpose in one sentence]
  ...
  Chapter N: [Title] — [Purpose in one sentence]

  Appendices:
    Appendix A: [Name]
    Appendix B: [Name]
    [...]

Supporting Material:
  [ ] Glossary          [ ] Index              [ ] Bibliography
  [ ] Solutions         [ ] Cheat sheets       [ ] Reference cards
  [ ] Quick start       [ ] FAQ                [ ] Further reading
  [ ] Acronym list      [ ] Notation reference [ ] Change log

VISUALS
────────────────────────────────────────────────────────────────────────
Estimated Diagram Count:   [N diagrams total]
Primary Diagram Tool:      [ ] TikZ  [ ] PlantUML  [ ] Graphviz  [ ] Mermaid
Visual Style:              [Technical / schematic / editorial / minimal]
Color Palette:             [Defined? Reference to STYLE_GUIDE.md palette]
Screenshot Policy:         [ ] Avoid  [ ] Permitted  [ ] Required for UI docs

CITATIONS
────────────────────────────────────────────────────────────────────────
Citation Strategy:         [ ] Formal (BibTeX)  [ ] Inline URLs  [ ] Endnotes
Reference Style:           [ ] IEEE  [ ] APA  [ ] Chicago  [ ] Custom
Target Citation Count:     [~N references]
Primary Source Types:      [ ] Academic papers  [ ] RFCs  [ ] Official docs
                           [ ] GitHub repos  [ ] Books  [ ] Industry reports

DELIVERABLES
────────────────────────────────────────────────────────────────────────
Primary Output Format:     [ ] PDF (LaTeX)  [ ] HTML  [ ] EPUB  [ ] Markdown
Secondary Formats:         [ ] HTML  [ ] EPUB  [ ] Docusaurus  [ ] MkDocs
                           [ ] mdBook  [ ] Sphinx  [ ] GitBook

Primary Deliverables:
  □ Main document (all chapters)
  □ Compiled PDF (if LaTeX target)
  □ All source files (.tex, .bib, .sty, diagram sources)
  □ QA report
  □ Bibliography
  □ Supporting materials (per list above)

QUALITY TARGETS
────────────────────────────────────────────────────────────────────────
Technical Accuracy Target:  [ ] Publication-grade (all claims cited)
                            [ ] Internal standard (key claims cited)
Review Process:             [ ] Self-QA only  [ ] Peer review  [ ] Expert review
Accessibility:              [ ] Alt text for all figures  [ ] Screen reader tested
Language:                   [ ] English  [ ] [Other]

CONSTRAINTS
────────────────────────────────────────────────────────────────────────
Time Constraint:   [Deadline or estimated time budget]
Scope Constraint:  [Any topics that must be included regardless of scope]
Format Constraint: [Publisher requirements, template restrictions]
Length Constraint: [Minimum / maximum length if specified]

BLUEPRINT STATUS
────────────────────────────────────────────────────────────────────────
Status:   [ ] Draft  [ ] Under Review  [ ] Approved  [ ] Superseded
Approved: [ ] Yes — proceed to RESEARCH.md
          [ ] No  — [Reason and required changes]
╚═══════════════════════════════════════════════════════════════════════╝
```

---

## Blueprint Validation Rules

A blueprint must pass all of these checks before research begins:

### Audience Validation
- [ ] Primary audience is specific enough to make calibration decisions
- [ ] "Everyone" or "all developers" is NOT acceptable — narrow it
- [ ] Experience level drives vocabulary and example complexity decisions
- [ ] Reader goal is concrete and measurable

### Scope Validation
- [ ] In-scope list is specific (not "everything about X")
- [ ] Out-of-scope list is explicit and reasoned
- [ ] The scope is achievable in the estimated length

### Structure Validation
- [ ] Chapter list is complete (not "etc." or "more chapters TBD")
- [ ] Every chapter has a purpose statement
- [ ] Chapter sequence is logically ordered
- [ ] Supporting material decisions are made (not deferred)

### Deliverables Validation
- [ ] Primary output format is chosen
- [ ] All deliverables are enumerated
- [ ] QA report is listed as a deliverable

---

## Blueprint for Micro-Documents

For short documents under 1,000 words (cheat sheets, quick reference articles, FAQs):

```
MICRO-DOCUMENT PLAN
───────────────────────────────────────────────────────────────
Title:         [Title]
Type:          [Cheat sheet / Quick reference / FAQ / etc.]
Audience:      [One sentence]
Purpose:       [One sentence]
Scope:         [What is covered / not covered]
Length:        [~N words / N pages]
Output format: [Markdown / PDF / HTML]
───────────────────────────────────────────────────────────────
```

---

## Blueprint Archival

After the publication is complete, update the blueprint with:

- Actual vs. estimated length
- Actual chapter count
- Scope changes made during writing (and why)
- QA outcomes
- Lessons for future publications

Store the final blueprint alongside the source files.

---

## Related Modules

- **PUBLICATION_TYPES.md** — Prerequisite. Select type before completing blueprint.
- **RESEARCH.md** — Runs after blueprint is approved.
- **CURRICULUM.md** — Runs after blueprint for educational publications.
- **SUPPORTING_MATERIAL.md** — Blueprint's supporting material section uses this module.
- **QUALITY.md** — Blueprint success criteria inform QA evaluation.
- **EXPORT.md** — Blueprint deliverables section drives export workflow.

---

## Version

```
Module:    PUBLICATION_BLUEPRINT.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Position:  After PUBLICATION_TYPES.md, before RESEARCH.md
```
