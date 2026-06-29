#!/usr/bin/env bash
# scripts/optimize-pdf.sh — Optimize PDF for distribution
# Usage: bash scripts/optimize-pdf.sh [input.pdf] [setting]
# Settings: screen | ebook | printer | prepress
# Default: input=output/book-latest.pdf, setting=ebook

set -euo pipefail

INPUT="${1:-output/book-latest.pdf}"
SETTING="${2:-ebook}"
BASE="${INPUT%.pdf}"
OUTPUT="${BASE}-${SETTING}.pdf"

if [ ! -f "${INPUT}" ]; then
    echo "ERROR: Input file not found: ${INPUT}"
    exit 1
fi

if ! command -v gs &>/dev/null; then
    echo "ERROR: Ghostscript (gs) not found."
    echo "Install: apt-get install ghostscript"
    exit 1
fi

echo "Optimizing PDF..."
echo "  Input:   ${INPUT} ($(du -h "${INPUT}" | cut -f1))"
echo "  Setting: ${SETTING}"
echo "  Output:  ${OUTPUT}"
echo ""

gs \
    -sDEVICE=pdfwrite \
    -dCompatibilityLevel=1.7 \
    -dPDFSETTINGS=/${SETTING} \
    -dNOPAUSE \
    -dQUIET \
    -dBATCH \
    -sOutputFile="${OUTPUT}" \
    "${INPUT}"

echo "Done."
echo "  Original:  $(du -h "${INPUT}" | cut -f1)"
echo "  Optimized: $(du -h "${OUTPUT}" | cut -f1)"

# Calculate compression ratio
ORIG=$(du -k "${INPUT}" | cut -f1)
OPTIM=$(du -k "${OUTPUT}" | cut -f1)
if [ "${ORIG}" -gt 0 ]; then
    RATIO=$(awk "BEGIN {printf \"%.0f\", (1 - ${OPTIM}/${ORIG}) * 100}")
    echo "  Reduction: ${RATIO}%"
fi

---

#!/usr/bin/env bash
# scripts/check-environment.sh — Verify all required tools are installed
# Run this before attempting any build.

set -uo pipefail

MISSING=0

check_tool() {
    local name="$1"
    local cmd="${2:-$1}"
    local version_flag="${3:---version}"

    if command -v "${cmd}" &>/dev/null; then
        version=$(${cmd} ${version_flag} 2>&1 | head -1 | sed 's/.*version //' | cut -c1-20)
        printf "  ✓ %-20s %s\n" "${name}" "${version}"
    else
        printf "  ✗ %-20s NOT FOUND\n" "${name}"
        MISSING=$((MISSING + 1))
    fi
}

echo "==========================================="
echo "  documentation-pro Environment Check"
echo "==========================================="
echo ""

echo "[LaTeX]"
check_tool "xelatex"    "xelatex"    "--version"
check_tool "lualatex"   "lualatex"   "--version"
check_tool "latexmk"    "latexmk"    "--version"
check_tool "biber"      "biber"      "--version"
check_tool "makeglossaries" "makeglossaries" "--version"
check_tool "makeindex"  "makeindex"  "--version"
echo ""

echo "[Diagram Tools]"
check_tool "Graphviz (dot)"  "dot"      "-V"
check_tool "Inkscape"        "inkscape" "--version"
check_tool "Mermaid (mmdc)"  "mmdc"     "--version"
if java -version 2>/dev/null; then
    echo "  ✓ Java (for PlantUML)"
else
    printf "  ✗ %-20s NOT FOUND\n" "Java (for PlantUML)"
    MISSING=$((MISSING + 1))
fi
echo ""

echo "[Export Tools]"
check_tool "pandoc"     "pandoc"     "--version"
check_tool "Ghostscript" "gs"        "--version"
echo ""

echo "[Validation Tools]"
check_tool "Vale"       "vale"       "--version"
check_tool "curl"       "curl"       "--version"
check_tool "Python 3"   "python3"    "--version"
echo ""

echo "[Optional]"
check_tool "tectonic"   "tectonic"   "--version"
check_tool "EPUBCheck"  "epubcheck"  "--version"
echo ""

echo "==========================================="
if [ "${MISSING}" -gt 0 ]; then
    echo "  Missing ${MISSING} required tool(s)."
    echo "  Install missing tools before building."
    echo "  See BUILD.md for installation instructions."
    exit 1
else
    echo "  All tools found. Ready to build."
fi
echo "==========================================="
