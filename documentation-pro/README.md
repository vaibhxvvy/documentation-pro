# documentation-pro v2.0

**Technical Knowledge Publishing Framework — Production-grade OpenCode Skill Package for AI Documentation Agents**

## What this skill does

This skill transforms an AI agent into a full-stack technical publishing system capable
of planning, researching, writing, illustrating, typesetting, compiling, validating, and
publishing complete technical documentation and educational publications at the level of:

- The Rust Reference
- Kubernetes documentation
- PostgreSQL Manual
- Google Engineering Practices
- O'Reilly technical handbooks
- IEEE and ACM publications
- Graduate-level university textbooks

## What's New in v2.0

v2.0 expands documentation-pro from a documentation framework into a **Technical Knowledge
Publishing Framework** supporting 24 publication types with full educational publishing support.

**New modules**:
| Module | Purpose |
|---|---|
| `PUBLICATION_TYPES.md` | Catalog of 24 publication types with module loading sequences |
| `PUBLICATION_BLUEPRINT.md` | Pre-writing planning: audience, scope, deliverables |
| `CURRICULUM.md` | Educational curriculum design workflow |
| `CHAPTER_PLAN.md` | Per-chapter planning before writing |
| `VISUAL_PLANNER.md` | Automatic diagram need evaluation and type selection |
| `HANDBOOK.md` | Complete educational handbook generation system |
| `SUPPORTING_MATERIAL.md` | Glossary, index, solutions, FAQ, cheat sheets, reference cards |
| `LONG_DOCUMENT.md` | Large document management: cross-refs, terminology, state |
| `KNOWLEDGE_QUALITY.md` | 11-dimension knowledge quality evaluation system |

**Extended modules**:
| Module | What was added |
|---|---|
| `DIAGRAMS.md` | Tool strengths/limitations, D2, 8 new diagram types |
| `QUALITY.md` | Section 16 (Educational Quality), Section 17 (Long Document) |
| `SKILL.md` | Updated to v2.0, new loading order, all 21 capabilities |

## File Map

```
documentation-pro/
├── SKILL.md                    Entry point. Load this first. Always.
│
├── SYSTEM.md                   Global rules: identity, accuracy, hallucination policy
├── STYLE_GUIDE.md              Voice, tone, grammar, terminology, cross-references
├── RESEARCH.md                 Research workflow, source ranking, confidence scoring
├── DOCUMENTATION.md            Chapter templates for 9 document types
├── LATEX.md                    LaTeX project structure, preamble, compilation
├── DIAGRAMS.md                 TikZ, PlantUML, Graphviz, D2, Mermaid — tools + standards
├── TABLES.md                   Comparison, benchmark, feature matrix, API tables
├── FIGURES.md                  Captions, placement, resolution, accessibility
├── CODE.md                     Listings, annotations, pseudocode, terminal sessions
├── CITATIONS.md                BibTeX formats, citation workflow, URL validation
├── BUILD.md                    Full build pipeline: latexmk, pandoc, CI/CD
├── QUALITY.md                  17-section QA checklist (incl. educational + large doc)
├── EXPORT.md                   PDF, HTML, EPUB, Docusaurus, MkDocs, mdBook, Sphinx
│
├── PUBLICATION_TYPES.md        [NEW] 24 publication types with module loading sequences
├── PUBLICATION_BLUEPRINT.md    [NEW] Publication planning: audience, scope, deliverables
├── CURRICULUM.md               [NEW] Curriculum design for educational publications
├── CHAPTER_PLAN.md             [NEW] Per-chapter planning template and validation
├── VISUAL_PLANNER.md           [NEW] Automatic visual planning and type selection
├── HANDBOOK.md                 [NEW] Educational handbook generation system
├── SUPPORTING_MATERIAL.md      [NEW] Glossary, index, solutions, FAQ, cheat sheets
├── LONG_DOCUMENT.md            [NEW] Large document management
├── KNOWLEDGE_QUALITY.md        [NEW] 11-dimension knowledge quality evaluation
│
├── templates/
│   ├── book.tex                      LaTeX book root template
│   ├── chapter.tex                   LaTeX chapter template
│   ├── api-doc.md                    API endpoint documentation template
│   └── rfc-whitepaper-architecture.md  RFC, whitepaper, arch doc templates
│
├── scripts/
│   ├── build.sh                      Full LaTeX build pipeline
│   ├── clean.sh                      Remove build artifacts
│   ├── render-diagrams.sh            Render PlantUML, Graphviz, Mermaid
│   ├── check-quality.sh              Automated QA checks
│   └── optimize-pdf.sh              Ghostscript PDF optimization
│
└── examples/
    ├── systems-book/
    │   └── ch05-memory-allocators.md  Complete chapter example
    └── api-reference/
        └── (API doc example)
```

## Supported Publication Types

| Type | Description |
|---|---|
| Technical Handbook | Complete educational resource, progressive learning |
| Developer Guide | Task-oriented developer documentation |
| Operations Manual | Runbooks, procedures, maintenance |
| User Manual | End-user documentation |
| Installation Guide | Setup and configuration |
| Architecture Guide | System design and decisions |
| Design Document | Internal proposals and specs |
| Research Report | Technical investigations |
| Whitepaper | Persuasive technical position |
| Tutorial | Outcome-focused learning |
| Course Material | Structured learning programs |
| Workshop Notes | Interactive session material |
| Lab Manual | Hands-on practical exercises |
| Knowledge Base | Self-contained Q&A articles |
| Reference Manual | Exhaustive lookup documentation |
| CLI Documentation | Command-line tools |
| API Reference | REST/gRPC/library APIs |
| SDK Guide | Language-specific libraries |
| RFC / Specification | Protocol and format specs |
| Standards Document | Formal standards |
| Best Practices Guide | Recommendations with rationale |
| Migration Guide | Version upgrade instructions |
| Troubleshooting Guide | Symptom → cause → solution |
| Internal Documentation | Team wikis and runbooks |

## Quick Start

**To produce a technical handbook**:
1. Load `SKILL.md` → `PUBLICATION_TYPES.md` (select Type 1)
2. Load `SYSTEM.md`, `STYLE_GUIDE.md`
3. Produce blueprint: `PUBLICATION_BLUEPRINT.md`
4. Run `RESEARCH.md` workflow
5. Design curriculum: `CURRICULUM.md`
6. Plan each chapter: `CHAPTER_PLAN.md`
7. Plan visuals: `VISUAL_PLANNER.md`
8. Write using `HANDBOOK.md` + `DOCUMENTATION.md`
9. Build with `scripts/build.sh`
10. Generate supporting material: `SUPPORTING_MATERIAL.md`
11. QA with `scripts/check-quality.sh` + `QUALITY.md` Sections 1–17

**To produce API documentation**:
1. Load `SKILL.md`, `PUBLICATION_TYPES.md` (select Type 17), `SYSTEM.md`, `STYLE_GUIDE.md`
2. Run `RESEARCH.md` (verify every parameter against official docs)
3. Fill `templates/api-doc.md`
4. QA with `QUALITY.md`

**To produce an RFC-style specification**:
1. Load `SKILL.md`, `PUBLICATION_TYPES.md` (select Type 19), `SYSTEM.md`, `STYLE_GUIDE.md`
2. Run `RESEARCH.md` to verify all normative behavior claims
3. Use `templates/rfc-whitepaper-architecture.md` RFC section
4. Verify: all normative keywords in ALL CAPS per RFC 2119

## Output Standards

Every deliverable from this skill meets:

- All technical claims verifiable from primary sources
- Zero LaTeX compilation errors
- Zero undefined cross-references
- All diagrams in vector format (PDF from TikZ or SVG→PDF)
- Complete bibliography with valid BibTeX entries
- QA checklist passed (all applicable sections of 17)
- Supporting material complete (glossary, index, solutions as applicable)

## License

This skill package is provided for use with OpenCode-compatible AI agents.
