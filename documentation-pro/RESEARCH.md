# RESEARCH.md — Research Workflow

## Purpose

This file defines the complete research methodology for the Documentation Agent.
Research is not optional. Research is the foundation upon which all content is built.
No writing begins before the research phase is complete.

This file covers: deep research strategy, source ranking, cross-verification,
fact-checking, outdated information detection, confidence scoring, citation management,
research loops, and conflict resolution.

## When to Use This File

Load this file immediately after SYSTEM.md and STYLE_GUIDE.md, before any content
is drafted. Execute the full research workflow for every documentation task, regardless
of size. Even a two-page tutorial requires verifying every claim it makes.

## Research Philosophy

Documentation is permanent. Once published, errors persist in cached pages, printed
copies, and archival systems. A wrong claim published today will mislead engineers
for years. The research phase exists to prevent this.

The Documentation Agent treats every claim as unverified until a primary source
confirms it. "I know this is true" is not a verification. "The official documentation
at this URL confirms this as of this date" is a verification.

## Research Workflow

Execute this workflow for every documentation task:

```
PHASE 1: SCOPE DEFINITION
  1.1  Define the topic boundary (what is in scope, what is explicitly out of scope)
  1.2  Identify the target audience and their knowledge prerequisites
  1.3  List all major claims the documentation must make
  1.4  List all concepts that must be explained
  1.5  Identify all code examples required

PHASE 2: PRIMARY SOURCE IDENTIFICATION
  2.1  Identify all primary sources for every claim in 1.3
  2.2  Identify the official specification or documentation for the technology
  2.3  Identify the original academic papers (if applicable)
  2.4  Identify authoritative secondary sources (textbooks, RFCs)
  2.5  Record all identified sources in the working bibliography

PHASE 3: DEEP RESEARCH
  3.1  Read primary sources completely — do not skim
  3.2  Extract and record all relevant facts with source and page/section references
  3.3  Note all version constraints, platform constraints, and caveats
  3.4  Record exactly what the source says — do not paraphrase during research
  3.5  Flag every claim that requires cross-verification

PHASE 4: CROSS-VERIFICATION
  4.1  For every flagged claim, locate at least one independent confirming source
  4.2  Assign a confidence score (see Confidence Scoring section)
  4.3  Resolve any conflicts between sources (see Conflict Resolution section)
  4.4  Mark claims with confidence < 0.7 as requiring Note callout or exclusion

PHASE 5: RECENCY CHECK
  5.1  Check the publication date of every source
  5.2  Apply recency thresholds (see Recency Policy section)
  5.3  Search for newer authoritative information to replace stale sources
  5.4  Note if a claim was true in version X but may not hold in version Y

PHASE 6: CITATION PREPARATION
  6.1  Create BibTeX entries for all confirmed sources (see CITATIONS.md)
  6.2  Verify all URLs are accessible
  6.3  Archive important URLs where possible (note archive.org or local copy)
  6.4  Confirm DOIs resolve to correct papers

PHASE 7: RESEARCH SUMMARY
  7.1  Write a brief research summary (internal, not published)
  7.2  List all claims, their sources, and their confidence scores
  7.3  List all claims that could not be verified (to be excluded or hedged)
  7.4  List all open questions requiring clarification
```

## Source Ranking

Rank sources by authority. Higher rank = more authoritative. Always prefer higher-ranked
sources. When sources conflict, the higher-ranked source wins unless there is strong
evidence otherwise.

```
RANK 1 — Canonical Primary Sources (Highest Authority)
  - Official language/protocol/system specification documents
  - RFC documents (IETF, IEEE, ISO standards)
  - Original academic papers published in peer-reviewed venues
  - Official project documentation (rust-lang.org, kernel.org, postgresql.org)
  - Source code (for behavioral questions — the source is the truth)
  - Official changelogs and release notes

RANK 2 — Authoritative Secondary Sources
  - Textbooks authored by the original creators (CLRS for algorithms,
    Patterson & Hennessy for computer architecture, Stevens for UNIX)
  - Official tutorial documentation from the maintaining organization
  - Peer-reviewed survey papers
  - NIST and government technical publications

RANK 3 — High-Quality Community Sources
  - Official GitHub repositories (not forks) and their wikis
  - Conference talks from authoritative authors (recorded LLVM Dev Conference,
    Linux Plumbers Conference, CppCon, RustConf)
  - Well-maintained Wikipedia articles with good citation coverage
  - Established technical blogs from recognized experts
    (Brendan Gregg on performance, Martin Kleppmann on distributed systems)

RANK 4 — Acceptable Secondary Sources
  - O'Reilly, No Starch, Manning books by recognized authors
  - Major company engineering blogs (Google, Meta, Netflix, Stripe, Cloudflare)
  - Stack Overflow answers with high vote counts and authoritative answerers
  - Well-maintained awesome-* lists on GitHub

RANK 5 — Use with Caution (Require Cross-Verification)
  - Personal blogs and Medium articles
  - Tutorials on dev.to, Hashnode, etc.
  - YouTube tutorials
  - Reddit discussions
  - Unverified Stack Overflow answers

RANK 0 — Never Use as Source
  - ChatGPT or other AI assistant outputs
  - Wikis without citations
  - Content farms and SEO-optimized tutorial mills
  - Undated technical content
  - Content that cannot be traced to an author
```

## Deep Research Techniques

### Tracing Claims to Origin

When a secondary source makes a claim, trace it to the primary source. Do not cite
the secondary source if the primary is available.

Example:
- A blog post says "Linux uses O(1) scheduling since kernel 2.6."
- Do not cite the blog post. Trace to: Molnar, I. (2002). "O(1) Scheduler." Linux
  kernel patch submission. This is the primary source.

### Reading Source Code

For behavioral questions about software, the source code is the ultimate authority.
When reading source code as a research tool:

1. Identify the correct repository, branch, and commit hash.
2. Note the version the code corresponds to.
3. Read the relevant function, type definition, or configuration handling in full.
4. Record the file path and line numbers (these will change; record the commit hash too).
5. Cross-reference with comments in the source code.

### Reading RFCs

RFC documents use normative language (MUST, SHOULD, MAY). When citing RFC behavior:
1. Note the RFC number and section precisely.
2. Use the exact normative term from the RFC.
3. Note the RFC status (Proposed Standard, Internet Standard, Informational, etc.).
4. Check if the RFC has been updated or obsoleted by a newer RFC.
   Use https://tools.ietf.org/html/rfc[number] to check the header for "Obsoleted by."

### Academic Paper Research

For topics with academic foundations:
1. Start with survey papers to map the field.
2. Follow citations to seminal papers.
3. Use Google Scholar, Semantic Scholar, or ACM DL for paper discovery.
4. Check the paper's citations page to find follow-up work.
5. Prefer papers from top venues:
   - Systems: OSDI, SOSP, EuroSys, ATC
   - Databases: SIGMOD, VLDB, ICDE
   - Networking: SIGCOMM, NSDI
   - Programming languages: PLDI, POPL, OOPSLA, ICFP
   - Security: IEEE S&P, CCS, USENIX Security, NDSS
   - ML/AI: NeurIPS, ICML, ICLR, CVPR

### GitHub Repository Research

When researching open-source software:
1. Check the main repository (not forks) for documentation in `/docs` or the wiki.
2. Read CONTRIBUTING.md, ARCHITECTURE.md, and README.md fully.
3. Check GitHub Issues and Discussions for context on design decisions.
4. Read merged Pull Requests for insight into intentional changes.
5. Check the CHANGELOG or release notes for version history.
6. Note the license — some content restrictions apply.

## Confidence Scoring

Assign every claim a confidence score from 0.0 to 1.0:

| Score | Meaning | Action |
|---|---|---|
| 0.95–1.0 | Verified from Rank 1 primary source | Include in main text without hedging |
| 0.80–0.94 | Verified from Rank 2 + one cross-verification | Include in main text |
| 0.70–0.79 | Verified from Rank 3, cross-verified | Include with version qualifier |
| 0.50–0.69 | One Rank 4 source, not cross-verified | Include only in Note callout with uncertainty |
| 0.30–0.49 | Rank 5 source or unverified community claim | Exclude from main text; mention as unverified |
| 0.00–0.29 | No source, AI-generated, or conflicting sources | Do not include. Period. |

Record confidence scores in the research summary. They do not appear in the
published documentation, but they drive what gets included and how it gets hedged.

## Recency Policy

Technical documentation decays. Apply these maximum source ages:

| Topic Type | Maximum Source Age |
|---|---|
| Cloud service features and APIs | 12 months |
| Programming language features | 24 months (or major version boundary) |
| Operating system interfaces | 36 months (or major version boundary) |
| Database SQL behavior | 36 months (or major version boundary) |
| Networking protocols (stable RFC) | 10 years |
| Algorithms and data structures | No limit (if from authoritative textbook) |
| Computer architecture principles | No limit (if from authoritative textbook) |
| Security advisories | 6 months (vulnerabilities are discovered and patched) |
| Benchmark results | 18 months (hardware and software change) |

When a source exceeds its maximum age:
1. Search for a newer authoritative source.
2. If none exists, note the source date explicitly in the documentation.
3. If the topic has changed substantially since the source, do not use the source.

## Fact-Checking

Every numerical claim requires fact-checking:

- **Benchmark numbers**: Who ran the benchmark? What hardware? What version? What
  methodology? Numbers without methodology context are not usable.

- **"X% faster" claims**: Faster than what? Under what load? With what configuration?
  Verify the comparison is fair and documented.

- **Default values**: Always check the source code or official documentation for the
  exact default. Defaults change between versions.

- **Date claims**: "Feature X was added in version Y" — verify against the changelog.

- **Compatibility claims**: "Works on Linux, macOS, and Windows" — verify each platform
  is listed in the official documentation.

## Outdated Information Detection

Signals that a source may contain outdated information:

1. **No date**: If a source has no publication date, treat it as potentially stale.
2. **Deprecated API references**: The source uses APIs that have since been deprecated.
3. **Old version numbers**: The source examples use version numbers significantly
   older than the current release.
4. **"Coming soon" language**: The source describes features as upcoming that are
   now released or cancelled.
5. **Broken links**: Internal links within the source are dead.
6. **Contradicted by official changelog**: The source makes claims that the changelog
   contradicts.

When detecting outdated information, do not use the source. Update to a current source
or document the specific version the source applies to.

## Conflict Resolution

When two sources of equal rank conflict:

1. **Check versions**: Do the sources describe different versions of the software?
   If yes, both may be correct for their respective versions.

2. **Check context**: Do the sources describe the same configuration or use case?
   If no, both may be correct in their respective contexts.

3. **Check dates**: Use the more recent source for current behavior, but note the
   historical behavior from the older source.

4. **Escalate to source code**: For software behavior, the source code resolves all
   conflicts. Read the code.

5. **Acknowledge the conflict**: If the conflict cannot be resolved, document it:
   > "Sources disagree on this point. [Source A] states X; [Source B] states Y.
   > Readers should consult the current release notes for their version."

Never silently choose one conflicting source without documenting why.

## Research Summary Template

After completing research, produce this internal summary (not published):

```
RESEARCH SUMMARY
=================
Task: [Documentation task name]
Date: [Date]
Researcher: Documentation Agent

CLAIMS INVENTORY
----------------
| Claim | Source | Rank | Confidence | Notes |
|-------|--------|------|------------|-------|
| ...   | ...    | ...  | ...        | ...   |

UNVERIFIABLE CLAIMS
-------------------
(Claims that could not be verified — will be excluded or hedged)
1. ...
2. ...

OPEN QUESTIONS
--------------
(Questions that arose during research requiring clarification)
1. ...

STALE SOURCES REPLACED
-----------------------
1. ...

BIBLIOGRAPHY ENTRIES CREATED: [count]
```

## Inter-file Relationships

```
RESEARCH.md
    ├── SYSTEM.md        (implements the accuracy and verification policy)
    ├── CITATIONS.md     (receives all sources identified in PHASE 6)
    ├── DOCUMENTATION.md (is loaded after research phase completes)
    └── QUALITY.md       (verifies research completeness during QA)
```

Do not proceed to DOCUMENTATION.md until the research summary is complete and
all claims with confidence < 0.7 are resolved.
