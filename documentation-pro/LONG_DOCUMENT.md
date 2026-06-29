# LONG_DOCUMENT.md — Large Document Management System

## Purpose

This module defines strategies and rules for managing documentation projects that
exceed the natural context window of a single writing session: books over 50,000 words,
multi-chapter handbooks, multi-volume documentation sets, and large knowledge bases.

Large documents fail in predictable ways:
- Cross-references break when chapters are added
- Terminology drifts chapter by chapter
- Glossary entries fall out of sync with usage
- Section numbering becomes inconsistent
- The same concept is explained differently in different chapters
- Bibliography entries are duplicated or inconsistent

This module prevents these failures.

## When to Load

Load for any publication that:
- Exceeds 20,000 words
- Has more than 8 chapters
- Spans multiple volumes
- Is maintained over time (updated, versioned)
- Has multiple contributors or sessions

## Dependencies

```
PUBLICATION_BLUEPRINT.md → LONG_DOCUMENT.md (alongside CURRICULUM.md)
```

---

## 1. Context Management

A Documentation Agent operating across a long document cannot hold the full text
in context. Apply these strategies:

### Context Management Strategy

**Maintain a Document State File** at the project root:

```
# document-state.md — Updated after every chapter

## Project: [Title]

### Chapters: Status

| Chapter | Title | Status | Word Count | Last Updated |
|---|---|---|---|---|
| 1 | [Title] | ✅ Complete | 5,240 | [Date] |
| 2 | [Title] | 🔄 In Progress | 2,100 | [Date] |
| 3 | [Title] | ⬜ Not Started | — | — |

### Terminology Decisions Made

| Term | Decision | Chapter Introduced |
|---|---|---|
| "goroutine" | Primary term (not "fiber") | Ch. 1 |
| "handler" | Used for HTTP handlers (not "controller") | Ch. 3 |

### Cross-References Pending

| Location | Reference Target | Status |
|---|---|---|
| Ch. 2 §2.3 | "see Ch. 5 for advanced usage" | ⬜ Ch. 5 not written yet |
| Ch. 4 §4.1 | "as introduced in Ch. 1" | ✅ Verified |

### Figures: Registry

| Figure ID | Title | Chapter | Source File | Status |
|---|---|---|---|---|
| Fig 1.1 | System Overview | Ch. 1 | figures/ch01/system-overview.tex | ✅ |
| Fig 2.1 | Request Flow | Ch. 2 | figures/ch02/request-flow.puml | ✅ |

### Glossary: Master List

All defined terms — see glossary.md for full entries.
Terms added this session: [term1], [term2]

### Open Issues

- [ ] Ch. 3 §3.2: Verify claim about [topic] against [source]
- [ ] Fig 4.2: Needs to match Fig 2.1 style (currently inconsistent)
- [ ] Ch. 6: Add cross-reference to Ch. 2 §2.4 (noted during writing)
```

**Update the Document State File after every chapter is completed.**

### Session Resumption Protocol

When resuming work on a long document after a context break:

1. Read `document-state.md` — understand what is done
2. Read the last completed chapter's final section — restore voice calibration
3. Read the current chapter's plan (CHAPTER_PLAN.md) — restore scope
4. Check open issues in document-state.md — address pending items
5. Do not reread entire previous chapters — trust the state file

---

## 2. Cross-Reference Management

Cross-references are links between chapters and sections. They break when content
is moved, renamed, or restructured.

### Cross-Reference Rules

**Rule 1: Use stable identifiers, not titles.**
Reference sections by structural position, not by title. Titles change. Structure changes less.
```
Preferred:  "See Section 3.2 for..."
Avoid:      "See the section on Request Lifecycles..." (title may change)
```

**Rule 2: Forward references must be resolved before delivery.**
A forward reference ("this is covered in Chapter 7") is acceptable during drafting.
Before delivery, every forward reference must resolve to a completed section.

**Rule 3: Use a cross-reference registry.**
Maintain a list of all cross-references in document-state.md. Mark each as:
- ✅ Resolved — both chapters written, reference verified
- ⬜ Pending — target chapter not yet written
- ❌ Broken — target section removed or restructured

**Rule 4: Verify all cross-references before QA.**
Before running QUALITY.md checklist, walk every cross-reference in the registry
and confirm the target exists at the stated location.

### Cross-Reference Format

Use this format consistently throughout the publication:

```
Prose format:      "See Section [N.M] for more on [topic]."
Parenthetical:     "[concept] (Section [N.M])"
Forward ref:       "Chapter [N] covers [topic] in depth."
Back ref:          "As introduced in Section [N.M], [brief restatement]..."
```

---

## 3. Section Numbering

Consistent section numbering is non-negotiable for long documents.

### Numbering Rules

**Chapter.Section.Subsection format**: `3.2.1` is Chapter 3, Section 2, Subsection 1.

**Never go deeper than three levels**: `3.2.1` is the maximum depth.
If you need a sub-subsection, restructure the content.

**Front matter is unnumbered**: Preface, Acknowledgments, Table of Contents.
Use Roman numerals for page numbers in front matter.

**Back matter**: Appendices use letters: Appendix A, Appendix B.
Sections within appendices: A.1, A.2, A.3.

**Figures and tables**: Numbered by chapter.sequence: Figure 3.2, Table 5.1.
Do not restart numbering for figures/tables within a chapter.

### LaTeX Section Numbering

In LaTeX, section numbering is automatic. Do not hardcode numbers in headings.
Use `\chapter{}`, `\section{}`, `\subsection{}` — never `## 3.2 Section Title`.

See LATEX.md for configuration of numbering depth and format.

---

## 4. Terminology Consistency

Terminology drift is the most common quality failure in long documents.

### Terminology Control System

**Before writing begins**:
1. Run CURRICULUM.md Terminology Registry
2. Choose exactly one term per concept
3. Document all synonyms as cross-references in the registry

**During writing**:
1. Before introducing any new term, check if it is in the registry
2. If not in registry: add it before using it
3. If in registry: use exactly the registered form (not a synonym)

**Terminology registry maintenance**:
Update document-state.md with every new term introduced. Never let the registry fall
behind the actual text.

### Common Drift Patterns to Avoid

| Wrong | Correct | Note |
|---|---|---|
| Mixing "goroutine" and "green thread" | Always "goroutine" (or always "green thread") | Pick one at the start |
| "library" in Ch. 1, "package" in Ch. 4 | Consistent throughout | Go uses "package" |
| "error" vs "exception" vs "fault" | Domain-specific: choose one | |
| "endpoint" vs "route" vs "handler" | Choose one per context | |
| API version numbers varying | Lock to one format: "v1.2.3" not "1.2.3" | |

### Terminology Audit

Before delivery, run a terminology audit:
1. For every term in the registry, search the document for all variants
2. Confirm every occurrence uses the registered form
3. Confirm every first use in a new chapter has a definition or cross-reference

---

## 5. Glossary Synchronization

The glossary must reflect the document exactly.

### Glossary Sync Rules

1. **Add entries during writing, not after.** When you introduce a new term, write
   the glossary entry immediately. Do not defer.

2. **Glossary entries must match chapter definitions.** If Chapter 3 defines "mutex"
   as "a synchronization primitive that...", the glossary entry must use the same
   or consistent definition.

3. **Before delivery**: walk every glossary entry and confirm:
   - The definition is accurate
   - The chapter reference is correct
   - The term appears in the chapter referenced
   - No terms are in the document but missing from the glossary

---

## 6. Visual Consistency Across Chapters

Diagrams produced early in a long document often differ from those produced later.

### Visual Consistency Rules

**Define the visual system in Chapter 1's first diagram.**
The first significant diagram establishes the standard. All subsequent diagrams
must use the same:
- Color palette
- Font
- Node shape conventions (rectangle = process, cylinder = database, etc.)
- Border style (rounded / sharp)
- Arrow type
- Line weight

**Document the conventions in document-state.md** under "Visual Style Decisions".

**Before delivery**: review all diagrams as a set. Inconsistencies found late
are expensive — they require regenerating source files.

### Visual Registry

Track all figures in document-state.md (Figure Registry section). Each entry records:
- Figure ID (e.g., Fig 3.2)
- Title
- Source file
- Tool used
- Status (draft / final)

---

## 7. Multi-Volume Documentation

For documentation sets spanning multiple volumes:

### Volume Coordination

Each volume is a self-contained publication with its own blueprint.
However, the set must coordinate:

**Shared assets**:
- `shared/styles/` — common LaTeX styles
- `shared/bib/` — shared bibliography
- `shared/glossary/` — master glossary (merged from all volumes)

**Cross-volume references**: Use descriptive references, not section numbers.
Section numbers are local to each volume.
```
Correct:  "Covered in Volume 2: [Topic]."
Avoid:    "See Volume 2, Section 4.3" (may change if Volume 2 is restructured)
```

**Terminology**: Create a master terminology registry for the entire set.
Every volume imports this registry. No term may be defined differently across volumes.

---

## 8. Reference Reuse

Long documents accumulate bibliography entries. Duplicates and formatting
inconsistencies are common.

### Reference Management Rules

1. **Single bibliography file** for the entire project: `references.bib`
2. **Never add a source without checking if it already exists** in the bib file
3. **Use consistent cite keys**: `AuthorYearTitle` format (e.g., `Lamport1978Time`)
4. **Verify every cite key before delivery**: compile with BibTeX and check the log

See CITATIONS.md for full bibliography management rules.

---

## 9. Index for Long Documents

Long documents require a proper index. See SUPPORTING_MATERIAL.md.

### Index Management for Long Documents

1. Add `\index{}` commands as you write (LaTeX) — do not defer
2. Maintain a list of indexed terms in document-state.md
3. Run `makeindex` during every build to catch errors early
4. Review the generated index for: missing entries, orphaned entries, inconsistent grouping

---

## 10. Delivery Checklist for Long Documents

In addition to QUALITY.md, run this checklist for long documents:

- [ ] Document state file is current (all chapters reflected)
- [ ] Cross-reference registry: all references marked ✅ Resolved
- [ ] Terminology audit passed (no synonym drift)
- [ ] Glossary synchronized with document
- [ ] Visual registry complete; all figures in final state
- [ ] Bibliography file: no duplicates, all cite keys valid
- [ ] Index generated and reviewed
- [ ] Section numbering: sequential, no gaps, no duplicates
- [ ] Chapter word counts match estimates (or deviation is documented)
- [ ] All open issues in document-state.md resolved or explicitly deferred

---

## Related Modules

- **PUBLICATION_BLUEPRINT.md** — Blueprint captures scope; LONG_DOCUMENT.md manages it.
- **CURRICULUM.md** — Terminology registry is established in curriculum phase.
- **CHAPTER_PLAN.md** — Chapter plans are the primary input to document-state.md.
- **DIAGRAMS.md** — Visual consistency is coordinated here.
- **CITATIONS.md** — Reference reuse rules are enforced by this module.
- **QUALITY.md** — Long document checklist supplements standard QA.
- **LATEX.md** — Section numbering, index generation, multi-file compilation.

---

## Version

```
Module:    LONG_DOCUMENT.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Position:  Load when publication exceeds 20,000 words or 8 chapters
```
