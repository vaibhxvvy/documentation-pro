#!/usr/bin/env bash
# scripts/build.sh — Full documentation build pipeline
# Usage: bash scripts/build.sh [project-name]
# Default project name: book

set -euo pipefail

PROJECT="${1:-book}"
OUT_DIR="output"

echo "========================================="
echo "  documentation-pro Build Pipeline"
echo "  Project: ${PROJECT}"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="
echo ""

# Ensure output directory exists
mkdir -p "${OUT_DIR}"

# Step 1: Render external diagrams
echo "[1/7] Rendering external diagrams..."
if [ -f "scripts/render-diagrams.sh" ]; then
    bash scripts/render-diagrams.sh
else
    echo "  No render-diagrams.sh found — skipping"
fi
echo ""

# Step 2: First XeLaTeX pass
echo "[2/7] First XeLaTeX pass (generating aux files)..."
xelatex \
    -interaction=nonstopmode \
    -file-line-error \
    -output-directory="${OUT_DIR}" \
    "${PROJECT}.tex" 2>&1 | grep -E "^(! |Error|Warning:.*undefined)" || true
echo "  Done."
echo ""

# Step 3: Bibliography (biber)
echo "[3/7] Processing bibliography with biber..."
biber --input-directory="${OUT_DIR}" --output-directory="${OUT_DIR}" "${PROJECT}" \
    2>&1 | grep -v "^INFO" | grep -v "^WARN.*package" | head -20 || true
echo "  Done."
echo ""

# Step 4: Glossary
echo "[4/7] Building glossary..."
makeglossaries -d "${OUT_DIR}" "${PROJECT}" 2>/dev/null || echo "  No glossary entries — skipping"
echo ""

# Step 5: Index
echo "[5/7] Building index..."
makeindex "${OUT_DIR}/${PROJECT}.idx" -o "${OUT_DIR}/${PROJECT}.ind" 2>/dev/null \
    || echo "  No index entries — skipping"
echo ""

# Step 6: Second XeLaTeX pass (resolves bibliography and glossary)
echo "[6/7] Second XeLaTeX pass (resolving bibliography)..."
xelatex \
    -interaction=nonstopmode \
    -file-line-error \
    -output-directory="${OUT_DIR}" \
    "${PROJECT}.tex" 2>&1 | grep -E "^(! |Error)" || true
echo "  Done."
echo ""

# Step 7: Third XeLaTeX pass (resolves remaining cross-references)
echo "[7/7] Third XeLaTeX pass (resolving cross-references)..."
xelatex \
    -interaction=nonstopmode \
    -file-line-error \
    -output-directory="${OUT_DIR}" \
    "${PROJECT}.tex" 2>&1 | grep -E "^(! |Error|Warning:.*undefined)" || true
echo "  Done."
echo ""

# Check for errors in log
ERRORS=$(grep -c "^! " "${OUT_DIR}/${PROJECT}.log" 2>/dev/null || echo "0")
UNDEF=$(grep -c "Warning:.*undefined" "${OUT_DIR}/${PROJECT}.log" 2>/dev/null || echo "0")

echo "========================================="
echo "  Build Summary"
echo "  LaTeX errors: ${ERRORS}"
echo "  Undefined references: ${UNDEF}"
if [ "${ERRORS}" -gt 0 ]; then
    echo "  STATUS: FAILED — fix errors before delivery"
    echo "  Log: ${OUT_DIR}/${PROJECT}.log"
    exit 1
elif [ "${UNDEF}" -gt 0 ]; then
    echo "  STATUS: WARNING — undefined references found"
    grep "Warning:.*undefined" "${OUT_DIR}/${PROJECT}.log" | head -10
else
    echo "  STATUS: SUCCESS"
fi
echo "  Output: ${OUT_DIR}/${PROJECT}.pdf"
ls -lh "${OUT_DIR}/${PROJECT}.pdf" 2>/dev/null || echo "  (PDF not found)"
echo "========================================="
