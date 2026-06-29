# CITATIONS.md — Citation Workflow

## Purpose

Defines how to create, manage, validate, and format citations. Every non-trivial
claim in the documentation must carry a citation. This file implements the accuracy
policy defined in SYSTEM.md.

A claim is "non-trivial" if a reasonable peer-level engineer could challenge it.
Universal mathematical truths, established definitions, and widely-known historical
facts may be stated without citation. Everything else must be cited.

## When to Use This File

Use this file during and after the research phase (RESEARCH.md). Create bibliography
entries as you locate sources — do not defer citation management to the end of the
project.

## BibTeX Entry Formats

### Journal Article

```bibtex
@article{Lamport1978,
  author  = {Lamport, Leslie},
  title   = {Time, Clocks, and the Ordering of Events in a Distributed System},
  journal = {Communications of the ACM},
  year    = {1978},
  volume  = {21},
  number  = {7},
  pages   = {558--565},
  doi     = {10.1145/359545.359563},
  url     = {https://doi.org/10.1145/359545.359563},
}
```

### Conference Paper

```bibtex
@inproceedings{Ongaro2014,
  author    = {Ongaro, Diego and Ousterhout, John},
  title     = {In Search of an Understandable Consensus Algorithm},
  booktitle = {2014 USENIX Annual Technical Conference (ATC '14)},
  year      = {2014},
  pages     = {305--320},
  publisher = {USENIX Association},
  address   = {Philadelphia, PA},
  url       = {https://www.usenix.org/conference/atc14/technical-sessions/presentation/ongaro},
}
```

### Book

```bibtex
@book{CLRS2022,
  author    = {Cormen, Thomas H. and Leiserson, Charles E. and Rivest, Ronald L.
               and Stein, Clifford},
  title     = {Introduction to Algorithms},
  edition   = {4th},
  year      = {2022},
  publisher = {MIT Press},
  address   = {Cambridge, MA},
  isbn      = {978-0-262-04630-5},
}
```

### RFC (IETF Technical Report)

```bibtex
@techreport{RFC8446,
  author      = {Rescorla, Eric},
  title       = {{The Transport Layer Security (TLS) Protocol Version 1.3}},
  type        = {RFC},
  number      = {8446},
  year        = {2018},
  month       = aug,
  institution = {Internet Engineering Task Force},
  url         = {https://tools.ietf.org/html/rfc8446},
  note        = {Standards Track},
}
```

### Website / Official Documentation

```bibtex
@online{PostgreSQLDocs2024,
  author  = {{The PostgreSQL Global Development Group}},
  title   = {PostgreSQL 16 Documentation: Write-Ahead Logging},
  year    = {2024},
  url     = {https://www.postgresql.org/docs/16/wal-intro.html},
  urldate = {2024-03-15},
}
```

### GitHub Repository

```bibtex
@misc{TokioRepo2024,
  author  = {{Tokio Contributors}},
  title   = {Tokio: An Asynchronous Runtime for the {Rust} Programming Language},
  year    = {2024},
  url     = {https://github.com/tokio-rs/tokio},
  urldate = {2024-03-15},
  version = {1.36.0},
  note    = {Repository commit: abc1234},
}
```

### Linux Kernel Documentation

```bibtex
@manual{LinuxKernelDocs2024,
  author  = {{The Linux Kernel Organization}},
  title   = {The Linux Kernel Documentation: Completely Fair Scheduler},
  year    = {2024},
  url     = {https://www.kernel.org/doc/html/latest/scheduler/sched-design-CFS.html},
  urldate = {2024-03-15},
  note    = {Kernel version 6.8},
}
```

### PhD Thesis / Dissertation

```bibtex
@phdthesis{Ongaro2014phd,
  author  = {Ongaro, Diego},
  title   = {Consensus: Bridging Theory and Practice},
  school  = {Stanford University},
  year    = {2014},
  url     = {https://web.stanford.edu/~ouster/cgi-bin/papers/OngaroPhD.pdf},
}
```

## Inline Citation Styles

In LaTeX with biblatex (IEEE style), citations appear as numbers:

```latex
% Single citation:
Raft was designed with understandability as the primary goal \cite{Ongaro2014}.

% Named citation (whitepaper / academic style):
\textcite{Lamport1978} introduced logical clocks as a mechanism for ordering events
in distributed systems.

% Multiple citations at once:
Several alternative implementations have emerged \cite{Raft2014, Howard2020, ETCD2024}.

% Citation with specific section or page:
The formal proof is given in \cite[Theorem~3.1]{Ongaro2014phd}.
```

In Markdown (for non-LaTeX outputs), use footnote-style citations:

```markdown
Raft was designed with understandability as the primary goal.[^ongaro2014]

[^ongaro2014]: Ongaro, D. and Ousterhout, J. "In Search of an Understandable
Consensus Algorithm." USENIX ATC, 2014. https://raft.github.io/raft.pdf
```

## BibTeX Key Naming Convention

Format: `FirstAuthorLastname` + `Year` (+ disambiguation letter if needed)

Examples:
- `Lamport1978` — single author
- `CormenEtal2022` — four or more authors (use first author + "Etal")
- `RFC8446` — for RFCs, use RFC + number
- `PostgreSQLDocs2024` — for org-authored docs, use org abbreviation
- `LinuxKernel6_8` — for versioned software docs, include version

Never use auto-generated keys like `ref1`, `bib23`, or `article2024a`.

## Required Fields by Entry Type

| Entry Type | Required Fields |
|---|---|
| `@article` | author, title, journal, year, volume, number, pages, doi |
| `@inproceedings` | author, title, booktitle, year, pages, publisher |
| `@book` | author, title, year, publisher, isbn |
| `@techreport` (RFC) | author, title, type, number, year, institution, url |
| `@online` | author, title, year, url, urldate |
| `@misc` (GitHub) | author, title, year, url, urldate |
| `@phdthesis` | author, title, school, year |

Missing required fields cause incomplete bibliography entries. `biber` will
warn about them. Fix all warnings before the final build.

## Citation Validation Checklist

Run this checklist before the final build:

- [ ] Every `\cite{}` or `\textcite{}` key has a matching entry in `references.bib`
- [ ] Every URL has been verified as accessible on the date of `urldate`
- [ ] Every DOI resolves correctly (test at https://doi.org/)
- [ ] Every RFC number is correct and uncorrupted (check that RFC header says what you cite)
- [ ] Every RFC has been checked for "Obsoleted by" at https://tools.ietf.org/html/rfcNNNN
- [ ] Book ISBNs are correct (verify at https://isbnsearch.org/)
- [ ] Author names match the title page of the paper, not other people's citations of it
- [ ] `biber` runs with zero warnings
- [ ] All `urldate` fields are filled in
- [ ] No duplicate keys in `references.bib`
- [ ] No orphaned `references.bib` entries (cited by nothing in the document)

## DOI and URL Handling

Prefer DOIs over direct URLs for academic papers. DOIs are permanent; URLs decay.

```bibtex
% Preferred (DOI):
doi = {10.1145/359545.359563},

% Acceptable (URL only when DOI unavailable):
url = {https://www.usenix.org/.../ongaro-raft.pdf},
urldate = {2024-03-15},
```

For official documentation that lacks DOIs, the URL plus `urldate` is the correct
citation form.

## Obsolete RFC Detection

Before citing any RFC, verify it has not been obsoleted:

```bash
curl -s "https://tools.ietf.org/html/rfc8446" | grep -i "obsoleted by"
# Should return nothing for a current RFC
```

If an RFC has been obsoleted, cite the obsoleting RFC instead (or both, if you need
to reference the historical original).

## Bibliography Compilation

The compilation pipeline (BUILD.md) runs biber automatically via latexmk.
For manual runs:

```bash
xelatex book.tex     # First pass: generate .aux
biber book           # Process bibliography
xelatex book.tex     # Second pass: resolve citations
xelatex book.tex     # Third pass: fix any remaining references
```

## Citing the Same Source Multiple Times

In LaTeX with biblatex, repeat the `\cite{}` call normally. The bibliography
entry appears only once. The back-reference feature (`backref=true` in preamble.sty)
adds page references to the bibliography entry automatically.

## Self-Citation Policy

When referencing earlier chapters in the same document, do not create a bibliography
entry. Use a cross-reference instead:

```latex
% Correct: use cross-reference for internal content
As discussed in \autoref{ch:memory-model}, ...

% Wrong: do not create a \cite{} for an internal chapter
```

## Inter-file Relationships

```
CITATIONS.md
    ├── RESEARCH.md        (all sources identified in research create bib entries here)
    ├── LATEX.md           (biblatex/biber configuration in preamble.sty)
    ├── BUILD.md           (biber step in the compilation pipeline)
    └── QUALITY.md         (citation validation checklist in QA phase)
```
