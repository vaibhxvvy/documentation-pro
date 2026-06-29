# QUALITY.md — Documentation Quality Assurance

## Purpose

This file defines the complete quality assurance process for documentation produced
by this skill. Every documentation deliverable must pass all applicable checks in
this file before it is considered complete.

QA is not an afterthought. It is the final gate between production and publication.
A document that fails QA is not ready for delivery, regardless of how polished the
prose appears.

## When to Use This File

Load this file after the build phase (BUILD.md) completes successfully. Run every
section of this checklist. Record the results. Do not deliver output that has failed
any required check without explicit acknowledgment from the requester.

## QA Checklist Overview

```
Section 1: Research completeness
Section 2: Structure completeness
Section 3: Style compliance
Section 4: Technical accuracy
Section 5: Code correctness
Section 6: Citations and bibliography
Section 7: Diagrams and figures
Section 8: Tables
Section 9: LaTeX compilation
Section 10: Spelling and grammar
Section 11: Cross-references and links
Section 12: Typography
Section 13: Accessibility
Section 14: Consistency
Section 15: Export and final output
```

---

## Section 1: Research Completeness

- [ ] Research summary exists and is complete (see RESEARCH.md Phase 7)
- [ ] All claims in the document appear in the research summary
- [ ] No claims with confidence score below 0.7 appear in main text without hedging
- [ ] All hedged claims use the hedging language defined in STYLE_GUIDE.md
- [ ] No claim is stated as fact that lacks a primary source
- [ ] All stale sources have been replaced or flagged with their applicable version
- [ ] No fabricated numbers (versions, benchmarks, defaults, dates)

**Automated check**: None (manual review required)

---

## Section 2: Structure Completeness

For every chapter (Technical Book template):

- [ ] Section 1: Overview is present (150–300 words)
- [ ] Section 2: Motivation is present (200–400 words)
- [ ] Section 3: Background is present or explicitly noted as N/A
- [ ] Section 4: Core Concepts is present (500–1500 words)
- [ ] Section 5: Architecture is present (if system chapter)
- [ ] Section 6: Implementation is present with working code examples
- [ ] Section 7: Examples present with 2–5 worked examples
- [ ] Section 8: Common Mistakes present with 3–7 items
- [ ] Section 9: Best Practices present with 3–7 items
- [ ] Section 10: Performance present (if performance-relevant)
- [ ] Section 11: Security present (if security-relevant)
- [ ] Section 13: Exercises present with 3–10 exercises, labelled by difficulty
- [ ] Section 14: Summary present (150–300 words)
- [ ] Section 15: Further Reading present with 3–10 references

**Automated check**:
```bash
# scripts/check-structure.sh
# Verifies that all required section headings exist in each chapter file
for chap in chapters/ch*.tex; do
    echo "Checking: ${chap}"
    required=(
        "Overview" "Motivation" "Core Concepts" "Implementation"
        "Examples" "Common Mistakes" "Best Practices" "Exercises"
        "Summary" "Further reading"
    )
    for section in "${required[@]}"; do
        if ! grep -q "\\\\section{.*${section}.*}" "${chap}" && \
           ! grep -q "## ${section}" "${chap}"; then
            echo "  MISSING: ${section}"
        fi
    done
done
```

---

## Section 3: Style Compliance

- [ ] Active voice used throughout (< 10% passive voice sentences)
- [ ] Oxford comma used in all lists
- [ ] Em dash (—) used correctly, not double hyphen (--)
- [ ] Numbers: one through nine spelled out; 10+ as numerals
- [ ] No contractions in reference/specification sections
- [ ] No forbidden words: "simply", "just", "obviously", "clearly", "trivially"
- [ ] Heading hierarchy correct (h1 only once per file; h2 sentence case)
- [ ] Paragraphs 3–7 sentences; no orphaned single-sentence paragraphs
- [ ] Lists have 3–7 items; introduced with a colon; items are parallel
- [ ] Callout boxes use only the five defined types: Note, Warning, Tip, Important, Example
- [ ] Cross-references use the exact format defined in STYLE_GUIDE.md
- [ ] Technical terms are defined at first use

**Automated check** (using Vale linter):
```bash
# Install: pip install vale
# Configure .vale.ini:
StylesPath = .vale/styles
MinAlertLevel = suggestion
[*.md]
BasedOnStyles = Vale, proselint

# Run:
vale chapters/*.md
```

`.vale.ini` configuration:
```ini
StylesPath = .vale/styles
MinAlertLevel = warning

[*.{md,tex}]
BasedOnStyles = Vale

[*.md]
Vale.Avoid = YES
Vale.Hedging = YES
Vale.Repetition = YES

# Custom rule: forbidden words
[*]
TokenIgnores = (\bmacOS\b|\bXeLaTeX\b|\bLuaLaTeX\b|\blatexmk\b)
```

Custom forbidden words rule `.vale/styles/Local/ForbiddenWords.yml`:
```yaml
extends: existence
message: "Avoid '%s' — it is vague and condescending."
level: error
tokens:
  - simply
  - just
  - obviously
  - clearly
  - trivially
  - easy
  - easily
  - straightforward
```

---

## Section 4: Technical Accuracy

- [ ] All version numbers verified against official release notes or documentation
- [ ] All default values verified against official documentation or source code
- [ ] All API signatures match the current official documentation
- [ ] All command-line flags verified against `--help` output or man page
- [ ] All RFC references point to the correct RFC number and section
- [ ] All performance claims include hardware, version, and methodology
- [ ] All security claims include threat model context
- [ ] No deprecated APIs presented as current without noting deprecation
- [ ] All compatibility claims (OS, version) are verified

**Manual verification process**:
1. Extract all version numbers from the document
2. Cross-check each against the official changelog
3. Extract all CLI commands and replay them in the target environment
4. Extract all API parameters and compare to official documentation

---

## Section 5: Code Correctness

- [ ] All code examples in Section 6 and 7 compile or parse without errors
- [ ] All code examples produce the stated output when run
- [ ] All code examples use the style defined in CODE.md
- [ ] All code examples have captions and labels
- [ ] All inline code uses `\code{}` (LaTeX) or backticks (Markdown) consistently
- [ ] No code example exceeds 50 lines in the main text (longer → appendix)
- [ ] Untested/illustrative code explicitly marked as such
- [ ] No hardcoded credentials, API keys, or real email addresses in examples
- [ ] No deprecated APIs without an explicit deprecation note

**Automated syntax check**:
```bash
# scripts/check-code.sh
# Extract code blocks and verify they parse

# Python
grep -n '```python' chapters/*.md | while IFS=: read file line _; do
    # Extract and attempt to parse with ast
    python3 -c "import ast; ast.parse(open('${file}').read())" 2>&1 \
        && echo "  OK: ${file}:${line}" \
        || echo "  FAIL: ${file}:${line}"
done

# Rust (using rustfmt --check)
find listings/ -name "*.rs" -exec rustfmt --check {} \; 2>&1

# YAML
find . -name "*.yaml" -o -name "*.yml" | xargs -I{} python3 -c \
    "import yaml, sys; yaml.safe_load(open('{}'))" 2>&1
```

---

## Section 6: Citations and Bibliography

- [ ] Every non-trivial claim has a `\cite{}` or footnote citation
- [ ] All `\cite{}` keys exist in `bibliography/references.bib`
- [ ] `biber` runs with zero errors and zero missing-field warnings
- [ ] All URLs in bibliography are accessible (HTTP 200 response)
- [ ] All DOIs resolve correctly
- [ ] No RFC is cited that has been obsoleted without noting the obsolescence
- [ ] All `urldate` fields are populated
- [ ] Author names in bibliography match the paper's title page
- [ ] No orphaned bibliography entries (in `.bib` but never cited)

**Automated URL check**:
```bash
# scripts/check-urls.sh
# Extract all URLs from references.bib and check HTTP status

grep 'url = {' bibliography/references.bib | \
    grep -oP 'https?://[^}]+' | \
    while read url; do
        status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "${url}")
        if [ "${status}" != "200" ] && [ "${status}" != "301" ] && [ "${status}" != "302" ]; then
            echo "  FAIL (${status}): ${url}"
        else
            echo "  OK (${status}): ${url}"
        fi
    done
```

---

## Section 7: Diagrams and Figures

- [ ] Every figure has a caption meeting the requirements in FIGURES.md
- [ ] Every figure has a `\label{}` and is referenced with `\autoref{}` in the text
- [ ] Every diagram is vector format (PDF from TikZ, or SVG→PDF from external tools)
- [ ] No diagram has elements smaller than 8pt at print size
- [ ] All diagrams are interpretable in grayscale (colorblind accessible)
- [ ] All source files preserved (`.tex`, `.puml`, `.dot`, `.mmd`)
- [ ] Figure numbering is sequential with no gaps
- [ ] `\listoffigures` compiles without undefined references

**Size check**:
```bash
# Check all figure PDFs are not rasterized (vector content check)
for f in figures/**/*.pdf; do
    page_count=$(pdfinfo "${f}" | grep "Pages:" | awk '{print $2}')
    has_fonts=$(pdffonts "${f}" | wc -l)
    echo "${f}: pages=${page_count} fonts=${has_fonts}"
done
```

---

## Section 8: Tables

- [ ] Every table has a caption (above table in LaTeX)
- [ ] Every table has a `\label{}` and is referenced in the text
- [ ] All tables use `booktabs` rules (`\toprule`, `\midrule`, `\bottomrule`)
- [ ] No table cells are blank (use "—" or "N/A" explicitly)
- [ ] Benchmark tables include hardware, version, and methodology in caption
- [ ] Numeric columns are right-aligned
- [ ] `\listoftables` compiles without undefined references
- [ ] No table exceeds the text width (use `tabularx` or `longtable` for wide tables)

---

## Section 9: LaTeX Compilation

- [ ] `latexmk -xelatex book.tex` exits with code 0
- [ ] Zero `! Error` lines in the log
- [ ] Zero `LaTeX Warning: Reference` ... undefined lines after three passes
- [ ] Zero `LaTeX Warning: Citation` ... undefined lines after biber pass
- [ ] Zero `Overfull \hbox` warnings exceeding 10pt
- [ ] PDF opens correctly in PDF viewer (test on at least one viewer)
- [ ] Bookmarks (PDF outline) are present and correct
- [ ] Table of contents, list of figures, list of tables, list of listings all present
- [ ] Page numbers are correct
- [ ] Headers and footers are correct on all page types (chapter start, normal, last)

**Automated log scan**:
```bash
# scripts/check-latex-log.sh
LOG="${1:-output/book.log}"

echo "=== LaTeX Log Analysis ==="

errors=$(grep -c "^! " "${LOG}" || echo 0)
echo "Errors: ${errors}"

undefined_refs=$(grep -c "Reference.*undefined" "${LOG}" || echo 0)
echo "Undefined references: ${undefined_refs}"

undefined_cites=$(grep -c "Citation.*undefined" "${LOG}" || echo 0)
echo "Undefined citations: ${undefined_cites}"

overfull=$(grep -c "Overfull" "${LOG}" || echo 0)
echo "Overfull boxes: ${overfull}"

if [ "${errors}" -gt 0 ] || [ "${undefined_refs}" -gt 0 ] || \
   [ "${undefined_cites}" -gt 0 ]; then
    echo ""
    echo "BUILD FAILED QA — fix the above issues before delivery."
    exit 1
fi

echo ""
echo "LaTeX QA: PASSED"
```

---

## Section 10: Spelling and Grammar

- [ ] Zero spelling errors in main text
- [ ] Zero spelling errors in figure captions
- [ ] Zero spelling errors in table captions
- [ ] Grammar check passes Vale linter at warning level
- [ ] No sentence over 40 words
- [ ] No paragraph over 7 sentences

**Automated spell check**:
```bash
# Using aspell
aspell list --lang=en_US --mode=tex < book.tex | sort -u

# Using pyspelling (with custom wordlist for technical terms)
pyspelling --config .pyspelling.yml

# .pyspelling.yml
matrix:
  - name: LaTeX
    sources:
      - 'chapters/*.tex'
    hunspell:
      d: en_US
    filters:
      - pyspelling.filters.latex:
          skip_commands:
            - cite
            - label
            - ref
            - autoref
            - code
            - filepath
            - cmd
    dictionary:
      wordlists:
        - .wordlist-technical.txt
```

`.wordlist-technical.txt` — add legitimate technical terms that would otherwise
be flagged as misspellings:
```
XeLaTeX
LuaLaTeX
latexmk
PostgreSQL
Kubernetes
gRPC
WebSocket
mutex
semaphore
...
```

---

## Section 11: Cross-References and Links

- [ ] All `\autoref{}` and `\ref{}` labels exist
- [ ] All chapter, section, figure, table, listing, and algorithm references resolve
- [ ] All URLs in the main text return HTTP 200
- [ ] No "see Chapter X" references that use hardcoded numbers (must use `\autoref{}`)
- [ ] All "see Figure X" references precede or immediately follow the figure
- [ ] No forward references to sections not yet written

**Automated check**:
```bash
# Check for undefined references in LaTeX log
grep "Reference.*undefined" output/book.log

# Extract and check URLs from Markdown
grep -oP 'https?://[^\s\)]+' chapters/*.md | \
    while read url; do
        curl -s -o /dev/null -w "%{url_effective} %{http_code}\n" \
             --max-time 10 "${url}"
    done | grep -v " 200$"
```

---

## Section 12: Typography

- [ ] Body text font renders correctly (not substituted with a fallback)
- [ ] Code font (JetBrains Mono) renders correctly
- [ ] Math fonts render correctly
- [ ] Line spacing is consistent throughout
- [ ] Chapter headings are visually distinct from section headings
- [ ] No widows (single line at top of page) or orphans (single line at bottom)
- [ ] No rivers of whitespace in justified text (check with microtype enabled)
- [ ] Page margins are consistent
- [ ] Headers and footers appear on all pages except chapter-opening pages

**Manual typography check**: Print or view two-page spreads of three random chapters.
Assess: readability, visual hierarchy, consistent spacing, no layout artifacts.

---

## Section 13: Accessibility

- [ ] All figures have meaningful alt text (for HTML/EPUB exports)
- [ ] All tables have captions that describe the table content
- [ ] Document structure uses semantic heading levels (h1 > h2 > h3, no skipping)
- [ ] PDF is tagged for accessibility (using `\usepackage{accessibility}` or post-processing)
- [ ] Color is never the sole means of conveying information (shape + label + color)
- [ ] Diagrams are interpretable in grayscale
- [ ] Code blocks use language labels (for screen reader announcement)
- [ ] Links in HTML export have descriptive anchor text (not "click here")

---

## Section 14: Consistency

- [ ] Same technical term used everywhere (no synonym drift)
- [ ] Same product name capitalization everywhere
- [ ] Same cross-reference format everywhere
- [ ] Same callout box style everywhere
- [ ] Same code listing caption format everywhere
- [ ] Same bibliography entry format for each source type
- [ ] Consistent tense throughout each section (present for specifications, past for history)
- [ ] Chapter structure is identical across all chapters (same sections, same order)

**Automated consistency check**:
```bash
# Check for synonym drift — find cases where both forms appear
terms=(
    "repository:repo"
    "function:method"
    "parameter:argument"
)

for pair in "${terms[@]}"; do
    term1="${pair%%:*}"
    term2="${pair##*:}"
    count1=$(grep -ci "\b${term1}\b" chapters/*.md 2>/dev/null || echo 0)
    count2=$(grep -ci "\b${term2}\b" chapters/*.md 2>/dev/null || echo 0)
    if [ "${count1}" -gt 0 ] && [ "${count2}" -gt 0 ]; then
        echo "INCONSISTENCY: Both '${term1}' (${count1}x) and '${term2}' (${count2}x) found."
    fi
done
```

---

## Section 15: Export and Final Output

- [ ] PDF opens without errors in Adobe Acrobat Reader and a free viewer (Evince, Preview)
- [ ] PDF bookmarks (outline) are complete and correct
- [ ] PDF metadata (title, author, subject, keywords) is set correctly
- [ ] PDF file size is reasonable (flag if > 50 MB for text-primary documents)
- [ ] HTML export (if applicable) validates with W3C HTML validator
- [ ] EPUB (if applicable) validates with EPUBCheck
- [ ] All required output formats specified in EXPORT.md are produced

**File size check**:
```bash
size=$(du -k "output/book-latest.pdf" | cut -f1)
if [ "${size}" -gt 51200 ]; then
    echo "WARNING: PDF is ${size} KB. Consider running optimize-pdf.sh."
fi
```

---

## QA Report Template

After running all checks, produce a QA report:

```
DOCUMENTATION QA REPORT
========================
Project: [name]
Date: [date]
Build: [PDF filename]
Agent: Documentation Agent

RESULTS SUMMARY
---------------
Section 1: Research completeness    [ PASS | FAIL | N/A ]
Section 2: Structure completeness   [ PASS | FAIL | N/A ]
Section 3: Style compliance         [ PASS | FAIL | N/A ]
Section 4: Technical accuracy       [ PASS | FAIL | N/A ]
Section 5: Code correctness         [ PASS | FAIL | N/A ]
Section 6: Citations                [ PASS | FAIL | N/A ]
Section 7: Diagrams and figures     [ PASS | FAIL | N/A ]
Section 8: Tables                   [ PASS | FAIL | N/A ]
Section 9: LaTeX compilation        [ PASS | FAIL | N/A ]
Section 10: Spelling and grammar    [ PASS | FAIL | N/A ]
Section 11: Cross-references        [ PASS | FAIL | N/A ]
Section 12: Typography              [ PASS | FAIL | N/A ]
Section 13: Accessibility           [ PASS | FAIL | N/A ]
Section 14: Consistency             [ PASS | FAIL | N/A ]
Section 15: Export                  [ PASS | FAIL | N/A ]

ISSUES FOUND
------------
[List each issue with section number, description, and severity: ERROR | WARNING]

DISPOSITION
-----------
[ ] READY FOR DELIVERY — all required checks pass
[ ] REQUIRES FIXES — [N] error(s) found; do not deliver until resolved
```

## Inter-file Relationships

```
QUALITY.md
    ├── SYSTEM.md          (quality standards defined there; validated here)
    ├── STYLE_GUIDE.md     (Section 3 validates compliance with style rules)
    ├── RESEARCH.md        (Section 1 validates research completeness)
    ├── DOCUMENTATION.md   (Section 2 validates structure completeness)
    ├── CODE.md            (Section 5 validates code listing standards)
    ├── CITATIONS.md       (Section 6 validates bibliography)
    ├── DIAGRAMS.md        (Section 7 validates diagram quality)
    ├── FIGURES.md         (Section 7 validates figure standards)
    ├── TABLES.md          (Section 8 validates table standards)
    ├── LATEX.md           (Section 9 validates compilation)
    ├── BUILD.md           (QA runs after BUILD.md pipeline completes)
    └── EXPORT.md          (Section 15 validates export deliverables)
```

---

## Section 16: Educational Quality (Handbooks and Courses)

Apply this section when the publication type is a handbook, course, workshop, tutorial, or lab manual.
Skip for purely reference publications.

### 16.1 Learning Objectives
- [ ] Global learning objectives present and measurable (action verbs used)
- [ ] Every chapter has chapter-level objectives
- [ ] Objectives span appropriate Bloom's Taxonomy levels for the stated audience
- [ ] All stated objectives are actually addressed in the chapter content

### 16.2 Audience Calibration
- [ ] Vocabulary matches stated audience level throughout
- [ ] Technical terms defined at first use for beginner/intermediate audiences
- [ ] No concepts used before they are introduced
- [ ] No condescension (over-explaining basics to advanced audience)
- [ ] No unexplained jargon (under-explaining to beginner audience)

### 16.3 Examples and Exercises
- [ ] Every major concept has at least one worked example
- [ ] All worked examples are complete (no omitted steps)
- [ ] All worked examples are annotated (non-obvious lines explained)
- [ ] All code examples produce the stated output when executed
- [ ] Every chapter has exercises (minimum 3)
- [ ] Exercise types are varied (not all recall or all coding)
- [ ] Exercises have difficulty indicators (⭐ / ⭐⭐ / ⭐⭐⭐)
- [ ] Exercise solutions exist (appendix or solutions directory)

### 16.4 Knowledge Scaffolding
- [ ] Knowledge check present at end of every chapter
- [ ] Key Takeaways section present and follows format (complete sentences, self-contained)
- [ ] Cheat sheets present for syntax-heavy chapters
- [ ] Chapter summary (150–300 words) accurately reflects chapter content
- [ ] Progressive difficulty: chapters increase in complexity appropriately

### 16.5 Supporting Material
- [ ] Glossary present and complete (all technical terms defined)
- [ ] Glossary entries have chapter references
- [ ] Further Reading annotated (not bare reference lists)
- [ ] Index present (for publications over 20,000 words)
- [ ] All appendices cross-referenced from main text

### 16.6 Pedagogical Completeness
- [ ] Common mistakes section present in chapters where pitfalls are known
- [ ] Best practices section present and backed by rationale
- [ ] Analogies used where concepts are abstract (especially beginner material)
- [ ] Prerequisites explicitly stated at chapter and book level
- [ ] Chapter dependency graph respected (no forward references to undefined concepts)

### 16.7 Coverage Quality
- [ ] All key concepts in the curriculum blueprint are addressed
- [ ] No significant gaps (topic promised by chapter title but not covered)
- [ ] No significant redundancy (same concept explained identically in multiple chapters)
- [ ] Scope matches blueprint (nothing out-of-scope included without justification)

---

## Section 17: Long Document Quality

Apply when publication exceeds 20,000 words or 8 chapters. See LONG_DOCUMENT.md.

- [ ] Document state file exists and is current
- [ ] All cross-references in registry marked ✅ Resolved
- [ ] Terminology audit passed (no synonym drift detected)
- [ ] Glossary synchronized with document (no undefined terms, no missing entries)
- [ ] Visual registry complete; all figures in final state
- [ ] Section numbering sequential throughout (no gaps, no duplicates)
- [ ] Bibliography file has no duplicate entries
- [ ] All open issues in document-state.md resolved or explicitly deferred with rationale

---

## Updated QA Report Template (v2)

```
DOCUMENTATION QA REPORT
========================
Project: [name]
Publication Type: [from PUBLICATION_TYPES.md]
Date: [date]
Build: [PDF/HTML/output filename]
Agent: Documentation Agent

RESULTS SUMMARY
---------------
Section 1:  Research completeness          [ PASS | FAIL | N/A ]
Section 2:  Structure completeness         [ PASS | FAIL | N/A ]
Section 3:  Style compliance               [ PASS | FAIL | N/A ]
Section 4:  Technical accuracy             [ PASS | FAIL | N/A ]
Section 5:  Code correctness               [ PASS | FAIL | N/A ]
Section 6:  Citations                      [ PASS | FAIL | N/A ]
Section 7:  Diagrams and figures           [ PASS | FAIL | N/A ]
Section 8:  Tables                         [ PASS | FAIL | N/A ]
Section 9:  LaTeX compilation              [ PASS | FAIL | N/A ]
Section 10: Spelling and grammar           [ PASS | FAIL | N/A ]
Section 11: Cross-references               [ PASS | FAIL | N/A ]
Section 12: Typography                     [ PASS | FAIL | N/A ]
Section 13: Accessibility                  [ PASS | FAIL | N/A ]
Section 14: Consistency                    [ PASS | FAIL | N/A ]
Section 15: Export                         [ PASS | FAIL | N/A ]
Section 16: Educational quality            [ PASS | FAIL | N/A ]
Section 17: Long document quality          [ PASS | FAIL | N/A ]

ISSUES FOUND
------------
[List each issue: Section N, description, severity: ERROR | WARNING | INFO]

DISPOSITION
-----------
[ ] READY FOR DELIVERY — all required checks pass
[ ] REQUIRES FIXES — [N] error(s) found; do not deliver until resolved
[ ] CONDITIONALLY READY — only WARNING/INFO issues; deliver with known limitations noted
```

## Updated Inter-file Relationships

```
QUALITY.md
    ├── SYSTEM.md              (quality standards defined there; validated here)
    ├── STYLE_GUIDE.md         (Section 3 validates compliance)
    ├── RESEARCH.md            (Section 1 validates research completeness)
    ├── DOCUMENTATION.md       (Section 2 validates structure completeness)
    ├── CODE.md                (Section 5 validates code listing standards)
    ├── CITATIONS.md           (Section 6 validates bibliography)
    ├── DIAGRAMS.md            (Section 7 validates diagram quality)
    ├── FIGURES.md             (Section 7 validates figure standards)
    ├── TABLES.md              (Section 8 validates table standards)
    ├── LATEX.md               (Section 9 validates compilation)
    ├── BUILD.md               (QA runs after BUILD.md pipeline completes)
    ├── EXPORT.md              (Section 15 validates export deliverables)
    ├── HANDBOOK.md            (Section 16 validates educational publications)
    ├── SUPPORTING_MATERIAL.md (Section 16 validates supporting material)
    ├── LONG_DOCUMENT.md       (Section 17 validates large documents)
    └── KNOWLEDGE_QUALITY.md   (runs after structural QA — evaluates knowledge substance)
```
