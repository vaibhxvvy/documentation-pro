# BUILD.md — Documentation Build Pipeline

## Purpose

This file defines the complete build pipeline for transforming source files into
published output. It covers LaTeX compilation, Markdown export, diagram rendering,
CI/CD integration, and troubleshooting.

The build system is designed to be reproducible: the same source files always
produce the same output on any machine with the required tools installed.

## Prerequisites

Install these tools before attempting any build:

```bash
# LaTeX distribution
# On Ubuntu/Debian:
sudo apt-get install texlive-full latexmk biber

# On macOS:
brew install --cask mactex
brew install latexmk

# On Arch Linux:
sudo pacman -S texlive-most texlive-extra biber

# Fonts (required for preamble.sty)
# JetBrains Mono: https://www.jetbrains.com/lp/mono/
# TeX Gyre fonts: included in texlive-full

# Diagram tools
sudo apt-get install graphviz inkscape   # Linux
brew install graphviz inkscape           # macOS

# PlantUML (requires Java)
sudo apt-get install default-jre
wget -O plantuml.jar https://github.com/plantuml/plantuml/releases/latest/download/plantuml.jar
# Place in /usr/local/bin/ and create a wrapper script

# Pandoc (for Markdown/HTML export)
sudo apt-get install pandoc

# Node.js tools (for Mermaid)
npm install -g @mermaid-js/mermaid-cli

# Python tools (for validation scripts)
pip install pyspelling vale
```

## Environment Verification

Before building, verify the environment:

```bash
# scripts/check-environment.sh
#!/usr/bin/env bash
set -e

echo "Checking build environment..."

check() {
    if command -v "$1" &>/dev/null; then
        echo "  ✓ $1 ($(${1} --version 2>&1 | head -1))"
    else
        echo "  ✗ $1 NOT FOUND — install it before building"
        MISSING=1
    fi
}

check xelatex
check latexmk
check biber
check makeglossaries
check makeindex
check graphviz
check inkscape
check plantuml
check pandoc
check mmdc

if [ "${MISSING}" = "1" ]; then
    echo ""
    echo "ERROR: Missing required tools. Install them and retry."
    exit 1
fi

echo ""
echo "Environment OK. Proceed with build."
```

## Standard Build: LaTeX to PDF

The primary build command:

```bash
# Full build (recommended)
latexmk -xelatex -synctex=1 -interaction=nonstopmode book.tex

# Equivalent manual sequence:
scripts/build.sh
```

The `scripts/build.sh` script:

```bash
#!/usr/bin/env bash
# scripts/build.sh — Full LaTeX build pipeline
set -euo pipefail

PROJECT="${1:-book}"
OUT_DIR="output"
FIGURES_DIR="figures"

echo "=== documentation-pro Build Pipeline ==="
echo "Project: ${PROJECT}"
echo ""

# Step 1: Render external diagrams
echo "[1/7] Rendering diagrams..."
bash scripts/render-diagrams.sh

# Step 2: First XeLaTeX pass (generates .aux, .toc, .lof, .lot)
echo "[2/7] First LaTeX pass..."
xelatex -interaction=nonstopmode -file-line-error "${PROJECT}.tex" \
    | grep -E "^(! |./)" || true

# Step 3: Bibliography (biber)
echo "[3/7] Processing bibliography..."
biber "${PROJECT}" 2>&1 | grep -v "^INFO" | grep -v "^WARN.*package" || true

# Step 4: Glossary
echo "[4/7] Building glossary..."
makeglossaries "${PROJECT}" 2>/dev/null || true

# Step 5: Index
echo "[5/7] Building index..."
makeindex "${PROJECT}.idx" 2>/dev/null || true

# Step 6: Second XeLaTeX pass (resolves bibliography and glossary)
echo "[6/7] Second LaTeX pass..."
xelatex -interaction=nonstopmode -file-line-error "${PROJECT}.tex" \
    | grep -E "^(! |./)" || true

# Step 7: Third XeLaTeX pass (resolves any remaining cross-references)
echo "[7/7] Third LaTeX pass..."
xelatex -interaction=nonstopmode -file-line-error "${PROJECT}.tex" \
    | grep -E "^(! |./) |Warning: Reference" || true

# Move output
mkdir -p "${OUT_DIR}"
cp "${PROJECT}.pdf" "${OUT_DIR}/${PROJECT}-$(date +%Y%m%d).pdf"
cp "${PROJECT}.pdf" "${OUT_DIR}/${PROJECT}-latest.pdf"

echo ""
echo "=== Build complete ==="
echo "Output: ${OUT_DIR}/${PROJECT}-latest.pdf"
ls -lh "${OUT_DIR}/${PROJECT}-latest.pdf"
```

## Diagram Rendering Pipeline

```bash
#!/usr/bin/env bash
# scripts/render-diagrams.sh
set -euo pipefail

FIGURES_DIR="figures"

echo "  Rendering PlantUML diagrams..."
find "${FIGURES_DIR}" -name "*.puml" | while read -r f; do
    base="${f%.puml}"
    echo "    Processing: ${f}"
    java -jar /usr/local/bin/plantuml.jar -tsvg "${f}" -o "$(dirname "${f}")"
    inkscape --export-pdf="${base}.pdf" "${base}.svg" 2>/dev/null
    echo "    → ${base}.pdf"
done

echo "  Rendering Graphviz diagrams..."
find "${FIGURES_DIR}" -name "*.dot" | while read -r f; do
    base="${f%.dot}"
    echo "    Processing: ${f}"
    dot -Tsvg "${f}" -o "${base}.svg"
    dot -Tpdf "${f}" -o "${base}.pdf"
    echo "    → ${base}.pdf"
done

echo "  Rendering Mermaid diagrams..."
find "${FIGURES_DIR}" -name "*.mmd" | while read -r f; do
    base="${f%.mmd}"
    echo "    Processing: ${f}"
    mmdc -i "${f}" -o "${base}.svg" -t neutral
    inkscape --export-pdf="${base}.pdf" "${base}.svg" 2>/dev/null
    echo "    → ${base}.pdf"
done

echo "  Diagram rendering complete."
```

## Clean Build

```bash
#!/usr/bin/env bash
# scripts/clean.sh
set -euo pipefail

echo "Cleaning build artifacts..."

# LaTeX artifacts
find . -name "*.aux" -o -name "*.log" -o -name "*.toc" \
       -o -name "*.lof" -o -name "*.lot" -o -name "*.lol" \
       -o -name "*.bbl" -o -name "*.bcf" -o -name "*.blg" \
       -o -name "*.run.xml" -o -name "*.out" -o -name "*.idx" \
       -o -name "*.ind" -o -name "*.ilg" -o -name "*.glo" \
       -o -name "*.gls" -o -name "*.acn" -o -name "*.acr" \
       -o -name "*.alg" -o -name "*.glg" -o -name "*.synctex.gz" \
       -o -name "*.fls" -o -name "*.fdb_latexmk" \
    | grep -v "output/" | xargs rm -f 2>/dev/null || true

echo "Clean complete."
```

## Pandoc Export: Markdown to Multiple Formats

Use pandoc to export LaTeX or Markdown sources to other formats.

### Markdown to HTML

```bash
pandoc chapters/ch01-introduction.md \
  --from markdown \
  --to html5 \
  --standalone \
  --css=assets/style.css \
  --toc \
  --toc-depth=3 \
  --highlight-style=tango \
  --output=output/html/ch01-introduction.html
```

### LaTeX to Markdown (for GitHub / README)

```bash
pandoc book.tex \
  --from latex \
  --to gfm \
  --extract-media=output/media \
  --output=output/README.md
```

### Markdown to EPUB

```bash
pandoc \
  frontmatter/metadata.yaml \
  chapters/ch01-introduction.md \
  chapters/ch02-*.md \
  --from markdown \
  --to epub \
  --epub-cover-image=assets/cover.jpg \
  --toc \
  --output=output/book.epub
```

### Markdown to PDF (via pandoc + XeLaTeX, for Markdown-first projects)

```bash
pandoc chapters/*.md \
  --from markdown \
  --to pdf \
  --pdf-engine=xelatex \
  --variable=mainfont:"TeX Gyre Termes" \
  --variable=monofont:"JetBrains Mono" \
  --variable=fontsize:11pt \
  --variable=geometry:margin=1in \
  --toc \
  --highlight-style=tango \
  --output=output/book.pdf
```

## Tectonic: Self-Contained LaTeX Engine

Tectonic is a modernized XeLaTeX distribution that downloads packages on demand,
making it ideal for CI environments without full TeX Live.

```bash
# Install tectonic
curl --proto '=https' --tlsv1.2 -fsSL https://drop.axo.dev/magic.sh | bash
# Or: cargo install tectonic

# Build with tectonic
tectonic -X compile book.tex

# Tectonic configuration file: Tectonic.toml
[doc]
name = "book"
bundle = "https://data1.fullyjustified.net/tlextras-2024.0r0.tar"

[[output]]
name = "default"
type = "pdf"
```

## Latexmk Configuration

The `.latexmkrc` file automates the multi-pass compilation:

```perl
# .latexmkrc

# Use XeLaTeX
$pdf_mode = 5;
$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';

# Output directory
$out_dir = 'output';

# Run makeglossaries automatically
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
add_cus_dep('acn', 'acr', 0, 'makeglossaries');
sub makeglossaries {
    my $dir = dirname($_[0]);
    my $base = basename($_[0]);
    return system("makeglossaries -d '$dir' '$base'");
}

# Run makeindex automatically
add_cus_dep('idx', 'ind', 0, 'makeindex');
sub makeindex {
    return system("makeindex $_[0]");
}

# Clean extra extensions
$clean_ext = "bbl bcf blg run.xml synctex.gz acr acn alg glo gls glg ist lol";
```

## PDF Optimization

After compilation:

```bash
# scripts/optimize-pdf.sh
#!/usr/bin/env bash
INPUT="${1:-output/book-latest.pdf}"
OUTPUT="${INPUT%.pdf}-optimized.pdf"

# Screen-optimized (ebook distribution)
gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.7 \
   -dPDFSETTINGS=/ebook \
   -dNOPAUSE -dQUIET -dBATCH \
   -sOutputFile="${OUTPUT}" \
   "${INPUT}"

echo "Original: $(du -h "${INPUT}" | cut -f1)"
echo "Optimized: $(du -h "${OUTPUT}" | cut -f1)"
```

PDF settings by use case:
- `/screen` — 72 DPI, smallest file (web preview)
- `/ebook` — 150 DPI, small file (e-reader)
- `/printer` — 300 DPI (desktop printing)
- `/prepress` — 300 DPI + color profiles (commercial press)

## Continuous Integration

### GitHub Actions Workflow

```yaml
# .github/workflows/build-docs.yml
name: Build Documentation

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-22.04

    steps:
      - uses: actions/checkout@v4

      - name: Install TeX Live
        run: |
          sudo apt-get update
          sudo apt-get install -y texlive-full latexmk biber
          sudo apt-get install -y graphviz inkscape default-jre

      - name: Install fonts
        run: |
          mkdir -p ~/.local/share/fonts
          # Download and install JetBrains Mono
          wget -q https://github.com/JetBrains/JetBrainsMono/releases/latest/download/JetBrainsMono.zip
          unzip -q JetBrainsMono.zip -d ~/.local/share/fonts/
          fc-cache -fv

      - name: Render diagrams
        run: bash scripts/render-diagrams.sh

      - name: Build PDF
        run: bash scripts/build.sh

      - name: Run quality checks
        run: bash scripts/check-quality.sh

      - name: Upload PDF artifact
        uses: actions/upload-artifact@v4
        with:
          name: documentation-pdf
          path: output/*.pdf

      - name: Deploy to GitHub Pages (on main only)
        if: github.ref == 'refs/heads/main'
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./output/html
```

## Build Error Reference

| Error | Stage | Resolution |
|---|---|---|
| `LaTeX Error: File 'package.sty' not found` | Pass 1 | Install missing package: `tlmgr install packagename` |
| `! Undefined control sequence` | Pass 1 | Typo in macro name, or package not loaded in preamble.sty |
| `biber: error: cannot find bib file` | biber | Check `\addbibresource{}` path in preamble.sty |
| `! Missing $ inserted` | Pass 1 | Underscore in text mode: use `\_` or `\textunderscore` |
| `Overfull \hbox` | Pass 1/2/3 | Long word/URL: use `\allowbreak`, `\url{}`, or rewrite |
| `LaTeX Warning: Reference ... undefined` | Pass 3 | Broken `\ref{}` or `\cite{}` key — fix the key |
| `plantuml: command not found` | Diagrams | Install PlantUML; add to PATH |
| `inkscape: error: no such file` | Diagrams | Install inkscape |

## Inter-file Relationships

```
BUILD.md
    ├── LATEX.md       (build depends on the LaTeX project structure defined there)
    ├── DIAGRAMS.md    (diagram rendering is step 1 of the build pipeline)
    ├── CITATIONS.md   (biber step processes bibliography/references.bib)
    ├── EXPORT.md      (export formats are built after the primary PDF build)
    └── QUALITY.md     (quality checks run after the build completes)
```
