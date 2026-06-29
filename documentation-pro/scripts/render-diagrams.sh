#!/usr/bin/env bash
# scripts/render-diagrams.sh — Render all external diagram sources to PDF/SVG
# Supports: PlantUML (.puml), Graphviz (.dot), Mermaid (.mmd)
# Run before LaTeX build.

set -euo pipefail

FIGURES_DIR="${1:-figures}"
PLANTUML_JAR="${PLANTUML_JAR:-/usr/local/bin/plantuml.jar}"
ERRORS=0

echo "  Scanning for diagrams in ${FIGURES_DIR}/..."

if [ ! -d "${FIGURES_DIR}" ]; then
    echo "  No figures directory found — skipping"
    exit 0
fi

# -------------------------------------------------------
# PlantUML diagrams (.puml → .svg → .pdf)
# -------------------------------------------------------
PUML_COUNT=0
find "${FIGURES_DIR}" -name "*.puml" | sort | while read -r f; do
    base="${f%.puml}"
    svg="${base}.svg"
    pdf="${base}.pdf"
    echo "  [PlantUML] ${f}"

    if [ ! -f "${PLANTUML_JAR}" ]; then
        echo "    ERROR: plantuml.jar not found at ${PLANTUML_JAR}"
        echo "    Set PLANTUML_JAR env var or install to /usr/local/bin/plantuml.jar"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    java -jar "${PLANTUML_JAR}" -tsvg -quiet "${f}" 2>/dev/null || {
        echo "    ERROR: PlantUML failed for ${f}"
        ERRORS=$((ERRORS + 1))
        continue
    }

    if command -v inkscape &>/dev/null; then
        inkscape --export-pdf="${pdf}" "${svg}" 2>/dev/null \
            && echo "    → ${pdf}" \
            || echo "    WARNING: inkscape conversion failed for ${svg}"
    else
        echo "    WARNING: inkscape not found — SVG available but PDF not generated"
        echo "    Install inkscape for PDF output: apt-get install inkscape"
    fi
    PUML_COUNT=$((PUML_COUNT + 1))
done
echo "  PlantUML: processed ${PUML_COUNT} file(s)"

# -------------------------------------------------------
# Graphviz diagrams (.dot → .svg + .pdf)
# -------------------------------------------------------
DOT_COUNT=0
find "${FIGURES_DIR}" -name "*.dot" | sort | while read -r f; do
    base="${f%.dot}"
    echo "  [Graphviz] ${f}"

    if ! command -v dot &>/dev/null; then
        echo "    ERROR: graphviz not found. Install: apt-get install graphviz"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    dot -Tsvg "${f}" -o "${base}.svg" && echo "    → ${base}.svg"
    dot -Tpdf "${f}" -o "${base}.pdf" && echo "    → ${base}.pdf"
    DOT_COUNT=$((DOT_COUNT + 1))
done
echo "  Graphviz: processed ${DOT_COUNT} file(s)"

# -------------------------------------------------------
# Mermaid diagrams (.mmd → .svg → .pdf)
# -------------------------------------------------------
MMD_COUNT=0
find "${FIGURES_DIR}" -name "*.mmd" | sort | while read -r f; do
    base="${f%.mmd}"
    echo "  [Mermaid] ${f}"

    if ! command -v mmdc &>/dev/null; then
        echo "    ERROR: Mermaid CLI (mmdc) not found. Install: npm install -g @mermaid-js/mermaid-cli"
        ERRORS=$((ERRORS + 1))
        continue
    fi

    mmdc -i "${f}" -o "${base}.svg" -t neutral --quiet 2>/dev/null \
        && echo "    → ${base}.svg"

    if command -v inkscape &>/dev/null; then
        inkscape --export-pdf="${base}.pdf" "${base}.svg" 2>/dev/null \
            && echo "    → ${base}.pdf"
    fi
    MMD_COUNT=$((MMD_COUNT + 1))
done
echo "  Mermaid: processed ${MMD_COUNT} file(s)"

echo ""
if [ "${ERRORS}" -gt 0 ]; then
    echo "  WARNING: ${ERRORS} diagram(s) failed to render. Check output above."
else
    echo "  All diagrams rendered successfully."
fi
