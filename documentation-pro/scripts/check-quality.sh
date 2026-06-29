#!/usr/bin/env bash
# scripts/check-quality.sh — Automated documentation QA
# Runs the automated portions of the QUALITY.md checklist.
# Usage: bash scripts/check-quality.sh [project-name]

set -uo pipefail

PROJECT="${1:-book}"
LOG="${2:-output/${PROJECT}.log}"
PASS=0
FAIL=0
WARN=0

separator() { echo ""; echo "-------------------------------------------"; }
pass() { echo "  ✓ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ✗ FAIL: $1"; FAIL=$((FAIL + 1)); }
warn() { echo "  ⚠ WARN: $1"; WARN=$((WARN + 1)); }

echo "==========================================="
echo "  documentation-pro Quality Check"
echo "  Project: ${PROJECT}"
echo "  $(date '+%Y-%m-%d %H:%M:%S')"
echo "==========================================="

# -------------------------------------------
# CHECK 1: LaTeX compilation
# -------------------------------------------
separator
echo "[1] LaTeX Compilation"

if [ -f "${LOG}" ]; then
    errors=$(grep -c "^! " "${LOG}" 2>/dev/null || echo "0")
    undef_refs=$(grep -c "Reference.*undefined" "${LOG}" 2>/dev/null || echo "0")
    undef_cites=$(grep -c "Citation.*undefined" "${LOG}" 2>/dev/null || echo "0")
    overfull=$(grep -c "Overfull" "${LOG}" 2>/dev/null || echo "0")

    [ "${errors}" -eq 0 ]      && pass "Zero LaTeX errors" || fail "LaTeX errors: ${errors}"
    [ "${undef_refs}" -eq 0 ]  && pass "Zero undefined references" || fail "Undefined references: ${undef_refs}"
    [ "${undef_cites}" -eq 0 ] && pass "Zero undefined citations" || fail "Undefined citations: ${undef_cites}"
    [ "${overfull}" -lt 5 ]    && pass "Overfull boxes: ${overfull} (< 5)" || warn "Overfull boxes: ${overfull}"

    if [ -f "output/${PROJECT}.pdf" ]; then
        SIZE_KB=$(du -k "output/${PROJECT}.pdf" | cut -f1)
        pass "PDF exists (${SIZE_KB} KB)"
        [ "${SIZE_KB}" -lt 51200 ] && pass "PDF size reasonable (< 50 MB)" \
            || warn "PDF is large (${SIZE_KB} KB) — consider running optimize-pdf.sh"
    else
        fail "PDF not found at output/${PROJECT}.pdf"
    fi
else
    fail "LaTeX log not found at ${LOG} — run build.sh first"
fi

# -------------------------------------------
# CHECK 2: Bibliography
# -------------------------------------------
separator
echo "[2] Bibliography"

if [ -f "bibliography/references.bib" ]; then
    pass "bibliography/references.bib exists"

    bib_count=$(grep -c "^@" bibliography/references.bib 2>/dev/null || echo "0")
    pass "Bibliography entries: ${bib_count}"

    # Check for entries missing urldate
    missing_urldate=$(grep -B5 "url = {" bibliography/references.bib | \
        grep -c "^@" 2>/dev/null || echo "0")
    # (simplified check — proper validation requires biber)
    pass "Bibliography file readable"
else
    warn "bibliography/references.bib not found"
fi

# Check for undefined references in bbl
if [ -f "output/${PROJECT}.blg" ]; then
    bib_errors=$(grep -c "^WARN.*missing" "output/${PROJECT}.blg" 2>/dev/null || echo "0")
    [ "${bib_errors}" -eq 0 ] && pass "biber: no missing field warnings" \
        || warn "biber: ${bib_errors} missing field warning(s) — check output/${PROJECT}.blg"
fi

# -------------------------------------------
# CHECK 3: Source file structure
# -------------------------------------------
separator
echo "[3] Source Structure"

[ -f "${PROJECT}.tex" ]                  && pass "${PROJECT}.tex exists"     || fail "${PROJECT}.tex not found"
[ -f "preamble.sty" ]                    && pass "preamble.sty exists"       || warn "preamble.sty not found"
[ -d "chapters" ]                        && pass "chapters/ directory exists" || fail "chapters/ not found"
[ -d "figures" ]                         && pass "figures/ directory exists"  || warn "figures/ not found"
[ -d "bibliography" ]                    && pass "bibliography/ directory exists" || warn "bibliography/ not found"
[ -f "frontmatter/preface.tex" ]         && pass "preface.tex exists"        || warn "frontmatter/preface.tex not found"

chapter_count=$(find chapters/ -name "ch*.tex" 2>/dev/null | wc -l || echo "0")
[ "${chapter_count}" -gt 0 ] && pass "Chapter files: ${chapter_count}" \
    || fail "No chapter files found in chapters/"

# -------------------------------------------
# CHECK 4: Forbidden words
# -------------------------------------------
separator
echo "[4] Forbidden Words"

FORBIDDEN=("simply" "just " "obviously" "clearly" "trivially" "it is easy")
CHAPTER_FILES=$(find chapters/ -name "*.tex" -o -name "*.md" 2>/dev/null | head -50)

for word in "${FORBIDDEN[@]}"; do
    count=0
    if [ -n "${CHAPTER_FILES}" ]; then
        count=$(echo "${CHAPTER_FILES}" | xargs grep -ci "${word}" 2>/dev/null \
            | awk -F: '{sum += $NF} END {print sum+0}' || echo "0")
    fi
    if [ "${count}" -gt 0 ]; then
        warn "Forbidden word '${word}' found ${count} time(s)"
    else
        pass "Forbidden word '${word}': not found"
    fi
done

# -------------------------------------------
# CHECK 5: URLs in bibliography
# -------------------------------------------
separator
echo "[5] URL Accessibility (spot check — first 5 URLs)"

if [ -f "bibliography/references.bib" ]; then
    URLS=$(grep -oP 'url = \{\K[^}]+' bibliography/references.bib 2>/dev/null | head -5)
    if [ -n "${URLS}" ]; then
        while IFS= read -r url; do
            if [ -z "${url}" ]; then continue; fi
            status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "${url}" 2>/dev/null || echo "000")
            case "${status}" in
                200|301|302) pass "URL accessible (${status}): ${url}" ;;
                000)         warn "URL unreachable (timeout): ${url}" ;;
                *)           fail "URL returned ${status}: ${url}" ;;
            esac
        done <<< "${URLS}"
    else
        warn "No URLs found in bibliography to check"
    fi
fi

# -------------------------------------------
# CHECK 6: Required section headings
# -------------------------------------------
separator
echo "[6] Chapter Structure (required sections)"

REQUIRED_SECTIONS=("Overview" "Motivation" "Core concepts" "Implementation"
                   "Examples" "Common mistakes" "Best practices" "Exercises"
                   "Summary" "Further reading")

for chap in chapters/ch*.tex chapters/ch*.md; do
    [ -f "${chap}" ] || continue
    echo "  Checking: ${chap}"
    for section in "${REQUIRED_SECTIONS[@]}"; do
        if grep -qi "${section}" "${chap}" 2>/dev/null; then
            : # pass silently — too verbose
        else
            warn "  Missing section: '${section}' in ${chap}"
        fi
    done
done

# -------------------------------------------
# CHECK 7: Figures
# -------------------------------------------
separator
echo "[7] Figures"

ORPHAN_SOURCES=0
find figures/ -name "*.puml" -o -name "*.dot" -o -name "*.mmd" 2>/dev/null | \
while read -r src; do
    base="${src%.*}"
    if [ ! -f "${base}.pdf" ] && [ ! -f "${base}.svg" ]; then
        warn "Unrendered diagram source: ${src}"
        ORPHAN_SOURCES=$((ORPHAN_SOURCES + 1))
    fi
done
[ "${ORPHAN_SOURCES}" -eq 0 ] && pass "All diagram sources have rendered outputs" || true

# -------------------------------------------
# SUMMARY
# -------------------------------------------
separator
echo ""
echo "==========================================="
echo "  QA Summary"
echo "  PASS: ${PASS}"
echo "  WARN: ${WARN}"
echo "  FAIL: ${FAIL}"
echo "==========================================="

if [ "${FAIL}" -gt 0 ]; then
    echo "  STATUS: FAILED — do not deliver until errors are resolved"
    exit 1
elif [ "${WARN}" -gt 5 ]; then
    echo "  STATUS: WARNING — review warnings before delivery"
    exit 0
else
    echo "  STATUS: PASSED — document meets quality standards"
    exit 0
fi
