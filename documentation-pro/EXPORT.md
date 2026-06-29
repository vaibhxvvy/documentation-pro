# EXPORT.md — Output Formats and Export Pipeline

## Purpose

This file defines how to produce every supported output format from the source
documentation. It covers PDF, Markdown, HTML, EPUB, GitBook, Docusaurus, MkDocs,
mdBook, Sphinx, and slide formats.

## Source Format Strategy

This skill supports two primary source formats:

**LaTeX-first**: Write in LaTeX, export to PDF as primary, derive other formats
via pandoc. Best for: books, technical references, academic papers, anything where
PDF quality is paramount.

**Markdown-first**: Write in Markdown, publish to static sites as primary, derive
PDF via pandoc+xelatex. Best for: software documentation portals, wikis, open-source
project docs that live on GitHub/GitLab.

Choose the source format based on the primary audience and distribution channel.
Do not try to use both as "primary" — pick one and derive the others.

---

## Format 1: PDF

PDF is the canonical output for LaTeX-first projects.

**Primary build command**:
```bash
latexmk -xelatex book.tex
```

See BUILD.md for the full pipeline. The PDF produced by this skill meets:
- PDF/A-1b standard (long-term archiving)
- Embedded fonts (no system font dependencies)
- Clickable hyperlinks and bookmarks
- Tagged PDF for accessibility (with `accessibility` package)
- Print-ready margins and bleed (when configured for commercial print)

**Print vs. Screen configuration** in `book.tex`:

```latex
% Screen version (colored links, no crop marks)
\hypersetup{colorlinks=true, linkcolor=blue, urlcolor=blue}

% Print version (black links, may add crop marks for commercial printing)
% \hypersetup{colorlinks=false}
% \usepackage[a4,cam,center]{crop}
```

Use two separate build targets in the Makefile:
```makefile
screen:
    latexmk -xelatex -jobname=book-screen book.tex

print:
    latexmk -xelatex -jobname=book-print book-print.tex
```

---

## Format 2: Markdown

Markdown export is used for: GitHub README, plain-text distribution, conversion
base for other formats.

**From LaTeX** (pandoc):
```bash
pandoc book.tex \
  --from latex \
  --to gfm \           # GitHub-flavored Markdown
  --extract-media=output/media \
  --output=output/book.md
```

**From Markdown source** (direct):
If the source is Markdown-first, the Markdown files are the primary deliverable.
Organize them as:
```
docs/
  index.md
  ch01-introduction.md
  ch02-topic.md
  ...
  SUMMARY.md           (for GitBook/mdBook)
  mkdocs.yml           (for MkDocs)
  _config.yml          (for GitHub Pages Jekyll)
```

---

## Format 3: HTML (Standalone)

Single-page or multi-page HTML using pandoc:

```bash
# Single page HTML
pandoc chapters/*.md \
  --from markdown \
  --to html5 \
  --standalone \
  --css=assets/style.css \
  --toc \
  --toc-depth=3 \
  --number-sections \
  --highlight-style=tango \
  --metadata title="Book Title" \
  --output=output/html/index.html

# Multi-page HTML (one file per chapter)
for f in chapters/ch*.md; do
    name=$(basename "${f}" .md)
    pandoc "${f}" \
      --from markdown \
      --to html5 \
      --standalone \
      --css=../../assets/style.css \
      --highlight-style=tango \
      --output="output/html/${name}.html"
done
```

**Minimal CSS** (`assets/style.css`):
```css
:root {
  --font-body: "TeX Gyre Termes", Georgia, serif;
  --font-mono: "JetBrains Mono", "Fira Code", monospace;
  --font-size: 16px;
  --line-height: 1.6;
  --max-width: 720px;
  --color-text: #1a1a1a;
  --color-bg: #ffffff;
  --color-accent: #1a56db;
  --color-code-bg: #f8f8f8;
}

body {
  font-family: var(--font-body);
  font-size: var(--font-size);
  line-height: var(--line-height);
  color: var(--color-text);
  background: var(--color-bg);
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 2rem 1.5rem;
}

h1, h2, h3 { font-family: var(--font-body); font-weight: bold; }
code, pre { font-family: var(--font-mono); font-size: 0.875em; }
pre { background: var(--color-code-bg); padding: 1rem; overflow-x: auto; border-radius: 4px; }
a { color: var(--color-accent); }
table { border-collapse: collapse; width: 100%; }
th, td { border: 1px solid #ddd; padding: 0.5rem; text-align: left; }
th { background: var(--color-code-bg); font-weight: bold; }
blockquote { border-left: 4px solid #ccc; margin: 0; padding-left: 1rem; color: #555; }
```

---

## Format 4: EPUB

EPUB export for e-reader distribution:

```bash
pandoc \
  frontmatter/metadata.yaml \
  chapters/ch01-*.md \
  chapters/ch02-*.md \
  --from markdown \
  --to epub3 \
  --epub-cover-image=assets/cover.jpg \
  --epub-css=assets/epub.css \
  --toc \
  --toc-depth=3 \
  --number-sections \
  --output=output/book.epub

# Validate the EPUB
java -jar epubcheck.jar output/book.epub
```

`frontmatter/metadata.yaml`:
```yaml
---
title: "Book Title"
author: "Author Name"
date: "2024"
lang: en-US
subject: "Technical Documentation"
description: "A comprehensive guide to..."
publisher: "Publisher Name"
rights: "Copyright © 2024 Author Name"
---
```

`assets/epub.css` (EPUB-specific; simpler than web CSS):
```css
body { font-family: serif; font-size: 1em; line-height: 1.5; }
code, pre { font-family: monospace; font-size: 0.9em; }
pre { white-space: pre-wrap; }
h1 { page-break-before: always; }
```

---

## Format 5: Docusaurus

Docusaurus is the recommended static site generator for software project documentation.

**Setup**:
```bash
npx create-docusaurus@latest docs-site classic --typescript
cd docs-site
```

**Content placement**:
```
docs-site/
  docs/
    intro.md              ← maps to /docs/intro
    ch01-introduction.md  ← maps to /docs/ch01-introduction
    ch02-topic.md
  docusaurus.config.ts
  sidebars.ts
```

`docusaurus.config.ts`:
```typescript
import type { Config } from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'Book Title',
  tagline: 'Subtitle or description',
  favicon: 'img/favicon.ico',
  url: 'https://your-domain.io',
  baseUrl: '/',

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          editUrl: 'https://github.com/org/repo/tree/main/',
        },
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    navbar: {
      title: 'Book Title',
      items: [
        { type: 'docSidebar', sidebarId: 'docsSidebar', position: 'left', label: 'Docs' },
        { href: 'https://github.com/org/repo', label: 'GitHub', position: 'right' },
      ],
    },
    prism: {
      theme: require('prism-react-renderer').themes.github,
      darkTheme: require('prism-react-renderer').themes.dracula,
      additionalLanguages: ['rust', 'bash', 'yaml', 'toml'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
```

**Build and deploy**:
```bash
npm run build
npm run serve         # Preview locally

# Deploy to GitHub Pages:
GIT_USER=<username> npm run deploy
```

---

## Format 6: MkDocs

MkDocs with Material theme is ideal for Python projects and teams preferring YAML config.

**Setup**:
```bash
pip install mkdocs mkdocs-material mkdocs-mermaid2-plugin
```

`mkdocs.yml`:
```yaml
site_name: Book Title
site_url: https://your-domain.io
site_description: Documentation description
site_author: Author Name
repo_url: https://github.com/org/repo
repo_name: org/repo

theme:
  name: material
  palette:
    - scheme: default
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-7
        name: Switch to dark mode
    - scheme: slate
      primary: indigo
      accent: indigo
      toggle:
        icon: material/brightness-4
        name: Switch to light mode
  font:
    text: Source Serif 4
    code: JetBrains Mono
  features:
    - navigation.tabs
    - navigation.tabs.sticky
    - navigation.sections
    - navigation.indexes
    - toc.integrate
    - search.suggest
    - content.code.copy
    - content.code.annotate

plugins:
  - search
  - mermaid2

markdown_extensions:
  - admonition
  - pymdownx.highlight:
      anchor_linenums: true
      line_spans: __span
  - pymdownx.inlinehilite
  - pymdownx.snippets
  - pymdownx.superfences:
      custom_fences:
        - name: mermaid
          class: mermaid
          format: !!python/name:pymdownx.superfences.fence_code_format
  - pymdownx.tabbed:
      alternate_style: true
  - tables
  - footnotes
  - attr_list
  - def_list

nav:
  - Home: index.md
  - Introduction: ch01-introduction.md
  - Chapter 2: ch02-topic.md
  - Reference:
    - API: reference/api.md
    - Glossary: reference/glossary.md

extra:
  version:
    provider: mike

copyright: Copyright &copy; 2024 Author Name
```

**Build and serve**:
```bash
mkdocs serve      # Local preview at http://localhost:8000
mkdocs build      # Produces site/ directory
mkdocs gh-deploy  # Deploy to GitHub Pages
```

---

## Format 7: mdBook

mdBook is the standard documentation tool for Rust projects.

**Setup**:
```bash
cargo install mdbook mdbook-mermaid mdbook-admonish
```

`book.toml`:
```toml
[book]
authors = ["Author Name"]
language = "en"
multilingual = false
src = "src"
title = "Book Title"

[output.html]
default-theme = "light"
preferred-dark-theme = "ayu"
git-repository-url = "https://github.com/org/repo"
edit-url-template = "https://github.com/org/repo/edit/main/{path}"
additional-css = ["theme/custom.css"]

[output.html.fold]
enable = true
level = 1

[preprocessor.mermaid]
command = "mdbook-mermaid"

[preprocessor.admonish]
command = "mdbook-admonish"
```

`src/SUMMARY.md` (required — defines structure):
```markdown
# Summary

[Introduction](README.md)

---

# Getting Started

- [Installation](ch01-installation.md)
- [Configuration](ch02-configuration.md)

# Reference

- [API Reference](reference/api.md)
- [Glossary](reference/glossary.md)

---

[Contributors](misc/contributors.md)
```

**Build**:
```bash
mdbook build      # Produces book/ directory
mdbook serve      # Local preview + live reload
mdbook test       # Run embedded code tests (Rust)
```

---

## Format 8: Sphinx

Sphinx is the standard for Python project documentation (also used by Linux kernel docs).

**Setup**:
```bash
pip install sphinx sphinx-rtd-theme myst-parser sphinx-copybutton
sphinx-quickstart docs/
```

`docs/conf.py`:
```python
project = 'Book Title'
author = 'Author Name'
release = '1.0.0'

extensions = [
    'myst_parser',          # Markdown support
    'sphinx.ext.autodoc',   # API doc from docstrings
    'sphinx.ext.viewcode',
    'sphinx.ext.napoleon',  # Google/NumPy docstring style
    'sphinx_copybutton',
]

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
html_css_files = ['custom.css']

myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "tasklist",
]

source_suffix = {
    '.rst': 'restructuredtext',
    '.md': 'markdown',
}
```

**Build**:
```bash
cd docs
make html     # Produces _build/html/
make latexpdf # Produces _build/latex/*.pdf
make epub     # Produces _build/epub/*.epub
```

---

## Format 9: Presentation Slides

For conference talks, internal presentations, or tutorial overviews derived from
the documentation.

**Beamer (LaTeX)** — best for academic and conference presentations:

```latex
\documentclass[aspectratio=169]{beamer}
\usetheme{metropolis}
\usepackage{preamble-slides}   % Simplified version of main preamble

\title{Chapter 3: Memory Models}
\subtitle{From the Book: [Book Title]}
\author{Author Name}
\date{\today}

\begin{document}
\maketitle

\begin{frame}{What we cover today}
  \tableofcontents
\end{frame}

\section{The problem}
\begin{frame}{Concurrent access to shared memory}
  \begin{columns}
    \column{0.5\textwidth}
    [Left column content]
    \column{0.5\textwidth}
    [Right column content / diagram]
  \end{columns}
\end{frame}
\end{document}
```

**Reveal.js (HTML)** — best for web-hosted interactive presentations:

```bash
pandoc chapters/ch03-memory.md \
  --from markdown \
  --to revealjs \
  --standalone \
  --variable revealjs-url=https://unpkg.com/reveal.js@5 \
  --variable theme=white \
  --variable transition=slide \
  --slide-level=2 \
  --output=output/slides/ch03-slides.html
```

---

## Export Pipeline Script

```bash
#!/usr/bin/env bash
# scripts/export-all.sh — Produce all configured output formats

set -euo pipefail

PROJECT="${1:-book}"
FORMATS="${2:-pdf,html,epub}"  # Comma-separated list of target formats

echo "=== Export Pipeline ==="
echo "Formats: ${FORMATS}"
echo ""

IFS=',' read -ra FORMAT_LIST <<< "${FORMATS}"

for fmt in "${FORMAT_LIST[@]}"; do
    echo "[${fmt}] Exporting..."
    case "${fmt}" in
        pdf)
            bash scripts/build.sh "${PROJECT}"
            ;;
        html)
            pandoc chapters/*.md \
              --from markdown --to html5 --standalone \
              --css=assets/style.css --toc \
              --output="output/html/index.html"
            echo "  → output/html/index.html"
            ;;
        epub)
            pandoc frontmatter/metadata.yaml chapters/*.md \
              --from markdown --to epub3 \
              --epub-cover-image=assets/cover.jpg \
              --output="output/${PROJECT}.epub"
            echo "  → output/${PROJECT}.epub"
            ;;
        md)
            pandoc "${PROJECT}.tex" --from latex --to gfm \
              --output="output/${PROJECT}.md"
            echo "  → output/${PROJECT}.md"
            ;;
        *)
            echo "  Unknown format: ${fmt} — skipping"
            ;;
    esac
done

echo ""
echo "=== Export complete ==="
ls -lh output/
```

## Inter-file Relationships

```
EXPORT.md
    ├── BUILD.md       (PDF export depends on the BUILD.md pipeline)
    ├── LATEX.md       (LaTeX source is the input for PDF and pandoc exports)
    └── QUALITY.md     (Section 15 validates all exported formats)
```
