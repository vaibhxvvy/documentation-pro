#!/usr/bin/env bash
# scripts/clean.sh — Remove LaTeX build artifacts
# Usage: bash scripts/clean.sh [--all]
# --all: also removes output PDFs and generated diagram files

set -euo pipefail

REMOVE_OUTPUT="${1:-}"

echo "Cleaning build artifacts..."

# LaTeX auxiliary files
find . -maxdepth 3 \( \
    -name "*.aux"    -o \
    -name "*.log"    -o \
    -name "*.toc"    -o \
    -name "*.lof"    -o \
    -name "*.lot"    -o \
    -name "*.lol"    -o \
    -name "*.bbl"    -o \
    -name "*.bcf"    -o \
    -name "*.blg"    -o \
    -name "*.run.xml" -o \
    -name "*.out"    -o \
    -name "*.idx"    -o \
    -name "*.ind"    -o \
    -name "*.ilg"    -o \
    -name "*.glo"    -o \
    -name "*.gls"    -o \
    -name "*.acn"    -o \
    -name "*.acr"    -o \
    -name "*.alg"    -o \
    -name "*.glg"    -o \
    -name "*.ist"    -o \
    -name "*.synctex.gz" -o \
    -name "*.fls"    -o \
    -name "*.fdb_latexmk" \
\) -not -path "./output/*" -delete 2>/dev/null || true

echo "  LaTeX artifacts: removed"

if [ "${REMOVE_OUTPUT}" = "--all" ]; then
    # Remove generated diagram files (but NOT source files)
    find figures/ -name "*.svg" -delete 2>/dev/null || true
    find figures/ -name "*.pdf" -delete 2>/dev/null || true
    echo "  Generated diagram files: removed"

    rm -rf output/
    echo "  Output directory: removed"
    echo "  WARNING: PDF output has been deleted."
else
    echo "  Output PDFs: preserved (use --all to remove)"
fi

echo "Done."
