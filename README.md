<div align="center">

# documentation-pro

**Technical Knowledge Publishing Framework**  
An AI agent skill for producing publication-quality technical documentation

[![Version](https://img.shields.io/badge/version-2.0.0-blue)](https://github.com/vaibhxvvy/documentation-pro/releases)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Skill Format](https://img.shields.io/badge/format-Anthropic%20Agent%20Skills%20Spec-purple)](https://opencode.ai/docs/skills/)

</div>

---

## Install — one command, all platforms

**macOS / Linux / WSL**
```bash
curl -fsSL https://raw.githubusercontent.com/vaibhxvvy/documentation-pro/main/install.sh | bash
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/vaibhxvvy/documentation-pro/main/install.ps1 | iex
```

**Manual (git)**
```bash
# Global — works in any project
git clone https://github.com/vaibhxvvy/documentation-pro ~/.config/opencode/skills/documentation-pro

# Or for Claude Code
git clone https://github.com/vaibhxvvy/documentation-pro ~/.claude/skills/documentation-pro
```

> **After install:** restart your agent. Say `"list installed skills"` to verify.

---

## What it does

documentation-pro turns your AI agent into a full-stack **Technical Knowledge Publishing Agent**.  
Not a formatter. Not a prompt template. A complete authoring, research, curriculum design, typesetting, and publishing system.

The agent can:

- Select from **24 publication types** (handbooks, API refs, RFCs, whitepapers, tutorials...)
- Plan publications with audience analysis, scope definition, and delivery blueprints
- Design educational curricula with concept sequencing and chapter plans
- Research using academic papers, RFCs, GitHub repos, and official docs
- Write book-length documentation with consistent voice and structure
- Generate educational handbooks with exercises, knowledge checks, cheat sheets, glossaries
- Plan and create diagrams automatically based on content type
- Build multi-file LaTeX projects → print-quality PDFs
- Generate glossaries, indexes, solutions, FAQs, reference cards
- Manage large documents with cross-reference registries and terminology control
- Run 28-point QA across 17 structural dimensions + 11 knowledge quality dimensions
- Export to PDF, HTML, EPUB, Docusaurus, MkDocs, mdBook, Sphinx, GitBook

---

## Supported agents

| Agent | Install path used | Status |
|---|---|---|
| [OpenCode](https://opencode.ai) | `~/.config/opencode/skills/` | ✅ Full support |
| [Claude Code](https://claude.ai/code) | `~/.claude/skills/` | ✅ Full support |
| [Cursor](https://cursor.sh) | `~/.agents/skills/` | ✅ Full support |
| [Windsurf](https://codeium.com/windsurf) | `~/.agents/skills/` | ✅ Full support |
| [Codex CLI](https://github.com/openai/codex) | `~/.agents/skills/` | ✅ Full support |
| Any Anthropic Agent Skills Spec agent | All paths | ✅ Full support |

The installer writes to **all** discovery paths simultaneously — one install, works everywhere.

---

## Supported publication types

| # | Type | Description |
|---|---|---|
| 1 | Technical Handbook | Complete educational resource, progressive learning |
| 2 | Developer Guide | Task-oriented developer documentation |
| 3 | Operations Manual | Runbooks, procedures, maintenance |
| 4 | User Manual | End-user documentation |
| 5 | Installation Guide | Setup and configuration |
| 6 | Architecture Guide | System design and decisions |
| 7 | Design Document | Internal proposals and specs |
| 8 | Research Report | Technical investigations |
| 9 | Whitepaper | Persuasive technical position |
| 10 | Tutorial | Outcome-focused learning |
| 11 | Course Material | Structured learning programs |
| 12 | Workshop Notes | Interactive session material |
| 13 | Lab Manual | Hands-on practical exercises |
| 14 | Knowledge Base | Self-contained Q&A articles |
| 15 | Reference Manual | Exhaustive lookup documentation |
| 16 | CLI Documentation | Command-line tools |
| 17 | API Reference | REST/gRPC/library APIs |
| 18 | SDK Guide | Language-specific libraries |
| 19 | RFC / Specification | Protocol and format specs |
| 20 | Standards Document | Formal standards |
| 21 | Best Practices Guide | Recommendations with rationale |
| 22 | Migration Guide | Version upgrade instructions |
| 23 | Troubleshooting Guide | Symptom → cause → solution |
| 24 | Internal Documentation | Team wikis and runbooks |

---

## Usage examples

After installing and restarting your agent:

```
"Write a technical handbook on Kubernetes networking for intermediate engineers"

"Generate a complete API reference for my FastAPI service"

"Create a whitepaper arguing for event-driven architecture in our microservices stack"

"Build a beginner handbook on Rust, with exercises and cheat sheets"

"Write an RFC for our new authentication protocol"

"Create operations runbooks for our PostgreSQL cluster"
```

---

## Module structure

The skill is a system of 24 interconnected modules:

```
SKILL.md                    Entry point — always loaded first
├── PUBLICATION_TYPES.md    Select from 24 publication types
├── PUBLICATION_BLUEPRINT.md Pre-writing planning
├── SYSTEM.md               Global rules and accuracy policy
├── STYLE_GUIDE.md          Voice, tone, grammar
├── RESEARCH.md             Research workflow
│
├── CURRICULUM.md           Educational curriculum design
├── CHAPTER_PLAN.md         Per-chapter planning
├── VISUAL_PLANNER.md       Automatic diagram planning
├── HANDBOOK.md             Educational handbook system
│
├── DOCUMENTATION.md        Chapter authoring templates
├── CODE.md                 Code listing standards
├── TABLES.md               Table standards
├── FIGURES.md              Figure and caption standards
├── DIAGRAMS.md             TikZ, PlantUML, Graphviz, D2, Mermaid
├── CITATIONS.md            BibTeX and citation workflow
├── LATEX.md                LaTeX typesetting
│
├── SUPPORTING_MATERIAL.md  Glossary, index, solutions, FAQ
├── LONG_DOCUMENT.md        Large document management
│
├── BUILD.md                Compilation pipeline
├── QUALITY.md              17-section structural QA
├── KNOWLEDGE_QUALITY.md    11-dimension knowledge QA
└── EXPORT.md               PDF, HTML, EPUB, static sites
```

---

## Output quality targets

Every publication produced with this skill meets:

- All technical claims cited from primary sources
- Zero LaTeX compilation errors (for PDF output)
- Zero undefined cross-references
- All diagrams in vector format
- Complete bibliography with valid BibTeX entries
- Structural QA checklist passed (17 sections)
- Knowledge quality evaluation passed (11 dimensions)
- Supporting material complete (glossary, index, solutions as applicable)

---

## Update

```bash
# Re-run the installer to update to the latest version
curl -fsSL https://raw.githubusercontent.com/vaibhxvvy/documentation-pro/main/install.sh | bash
```

---

## Uninstall

```bash
rm -rf ~/.config/opencode/skills/documentation-pro
rm -rf ~/.claude/skills/documentation-pro
rm -rf ~/.opencode/skills/documentation-pro
rm -rf ~/.agents/skills/documentation-pro
```

---

## License

MIT — built by [vaibhxvvy](https://github.com/vaibhxvvy)
