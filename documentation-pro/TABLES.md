# TABLES.md — Table Standards

## Purpose

This file defines the structure and content requirements for every table type used
in documentation. Tables are used only when content is genuinely tabular — meaning
it has multiple attributes across multiple items. Use prose otherwise.

## Table Types

### Comparison Table

Compares multiple options across multiple attributes. Ideal for feature matrices,
technology comparisons, algorithm trade-offs.

```latex
\begin{table}[H]
\centering
\caption{Comparison of consensus algorithms by key properties.}
\label{tab:consensus-comparison}
\begin{tabularx}{\textwidth}{lXXXX}
  \toprule
  \textbf{Algorithm} & \textbf{Leader election} & \textbf{Fault tolerance}
                     & \textbf{Message complexity} & \textbf{Use case} \\
  \midrule
  Raft      & Yes (single) & $f < n/2$ failures & $O(n)$ per entry  & Distributed logs \\
  Paxos     & Yes (single) & $f < n/2$ failures & $O(n)$ per phase  & Consensus services \\
  PBFT      & Yes (rotating) & $f < n/3$ failures & $O(n^2)$ per req  & Byzantine faults \\
  Viewstamped & Yes (single) & $f < n/2$ failures & $O(n)$ per entry  & Replicated state \\
  \bottomrule
\end{tabularx}
\end{table}
```

Rules for comparison tables:
- Use `booktabs` rules: `\toprule`, `\midrule`, `\bottomrule`. Never use `\hline`.
- Bold all column headers.
- Align text columns left, numeric columns right, short values center.
- Never leave a cell blank — use "N/A" or "—" explicitly.

### Benchmark Table

Documents performance measurements. Must include methodology reference.

```latex
\begin{table}[H]
\centering
\caption{Read throughput under varying concurrency. Hardware: AWS c6i.4xlarge
         (16 vCPU, 32 GB RAM). Version: PostgreSQL 16.2. Methodology: pgbench,
         60-second runs, 3 trials averaged.}
\label{tab:read-benchmark}
\begin{tabular}{rrrr}
  \toprule
  \textbf{Concurrency} & \textbf{TPS (avg)} & \textbf{Latency p50 (ms)}
                        & \textbf{Latency p99 (ms)} \\
  \midrule
  1   &  1{,}243 & 0.80 &  1.20 \\
  8   &  9{,}812 & 0.82 &  1.45 \\
  32  & 31{,}004 & 1.03 &  3.80 \\
  64  & 44{,}291 & 1.44 & 12.30 \\
  128 & 41{,}800 & 3.06 & 42.00 \\
  \bottomrule
\end{tabular}
\end{table}
```

Rules for benchmark tables:
- Caption MUST include: hardware, software version, methodology, trial count.
- Use thousands separator with `{,}` in LaTeX for numbers ≥ 1000.
- Align numeric columns with `r`.
- Include standard deviation or confidence intervals when available.
- State clearly whether higher or lower is better for each metric.

### Feature Matrix

Boolean-valued attributes across many items. Use checkmarks and X marks.

```latex
\newcommand{\yes}{\checkmark}
\newcommand{\no}{—}

\begin{table}[H]
\centering
\caption{Feature support matrix across database backends.}
\label{tab:feature-matrix}
\begin{tabular}{lccccc}
  \toprule
  \textbf{Feature} & \textbf{PostgreSQL} & \textbf{MySQL} & \textbf{SQLite}
                   & \textbf{MongoDB} & \textbf{Redis} \\
  \midrule
  ACID transactions  & \yes & \yes  & \yes  & \yes  & \no \\
  Full-text search   & \yes & \yes  & \no   & \yes  & \no \\
  JSON support       & \yes & \yes  & \yes  & \yes  & \yes \\
  Window functions   & \yes & \yes  & \yes  & \no   & \no \\
  Foreign keys       & \yes & \yes  & \yes  & \no   & \no \\
  Replication        & \yes & \yes  & \no   & \yes  & \yes \\
  \bottomrule
\end{tabular}
\end{table}
```

### API Parameter Table

Documents function parameters, request parameters, or configuration fields.

```
| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `timeout` | integer | No | 30 | Maximum seconds to wait for a response. |
| `retries` | integer | No | 3 | Number of retry attempts on transient failure. |
| `token` | string | Yes | — | Bearer authentication token. |
| `endpoint` | string | Yes | — | Base URL of the API (without trailing slash). |
```

Rules for API tables:
- Parameter names in backticks (code style).
- Required column: "Yes" or "No" — not checkmarks (screen reader friendly).
- Default: "—" when no default (required or dynamically determined).
- Description: complete sentence ending with a period.

### Specification Table

Precise numerical or enumerated specifications.

```latex
\begin{table}[H]
\centering
\caption{TLS 1.3 cipher suite specifications mandated by RFC 8446.}
\label{tab:tls13-ciphers}
\begin{tabular}{lll}
  \toprule
  \textbf{Cipher Suite} & \textbf{AEAD} & \textbf{Hash} \\
  \midrule
  TLS\_AES\_128\_GCM\_SHA256      & AES-128-GCM & SHA-256 \\
  TLS\_AES\_256\_GCM\_SHA384      & AES-256-GCM & SHA-384 \\
  TLS\_CHACHA20\_POLY1305\_SHA256 & ChaCha20-Poly1305 & SHA-256 \\
  \bottomrule
\end{tabular}
\end{table}
```

### Decision Matrix

Evaluates options against weighted criteria. Used in architecture and design documents.

| Criterion | Weight | Option A | Option B | Option C |
|---|---|---|---|---|
| Latency | 40% | 9/10 | 7/10 | 5/10 |
| Cost | 25% | 6/10 | 8/10 | 10/10 |
| Maintainability | 20% | 8/10 | 9/10 | 5/10 |
| Ecosystem | 15% | 10/10 | 7/10 | 6/10 |
| **Weighted score** | — | **8.05** | **7.7** | **6.35** |

Show the weighted score formula in a note below the table.

---

# FIGURES.md — Figure Standards

## Purpose

Defines captions, placement, resolution, numbering, and quality standards for
all figures (diagrams, screenshots, illustrations, charts).

## Caption Requirements

Every figure must have a caption. The caption must include:
1. **What** the figure shows (not its title — its content).
2. **Context** that is not obvious from looking at the figure alone.
3. **Source** if the figure is adapted from another work (with citation).

Format:
```
Caption: [What is shown]. [Context or interpretation]. [Source, if applicable].
```

Examples:
- ✅ "The Raft leader election process. A node becomes a candidate when its election
  timeout expires without receiving a heartbeat. After receiving votes from a majority,
  it becomes the leader."
- ❌ "Figure 3.2: Raft election." (too terse — says nothing)
- ❌ "This figure shows how Raft performs leader election in a distributed system
  where nodes can fail." (too verbose — the diagram shows this; state what the caption
  adds beyond the diagram)

## Placement

In LaTeX, use `[H]` (float here, requires `float` package) for most figures.
Use `[ht]` for figures that can float to the top of the page if needed.
Use `[p]` for full-page figures.

Never use bare `[h]` — LaTeX sometimes ignores it, causing unexpected placement.

Placement rule of thumb:
- Single-page figures with direct textual reference: `[H]`
- Supplementary figures that enhance but are not required inline: `[ht]`
- Large diagrams (half-page or more): `[p]`

## Figure Width

Standard widths for common figure types:

```latex
\includegraphics[width=\textwidth]{...}         % Full text width
\includegraphics[width=0.9\textwidth]{...}      % Slightly inset (most figures)
\includegraphics[width=0.6\textwidth]{...}      % Narrow diagrams
\includegraphics[width=0.45\textwidth]{...}     % Side-by-side figures
```

For side-by-side figures:
```latex
\begin{figure}[H]
  \centering
  \begin{subfigure}[b]{0.45\textwidth}
    \centering
    \input{figures/ch03/before-optimization}
    \caption{Before optimization.}
    \label{fig:before}
  \end{subfigure}
  \hfill
  \begin{subfigure}[b]{0.45\textwidth}
    \centering
    \input{figures/ch03/after-optimization}
    \caption{After optimization.}
    \label{fig:after}
  \end{subfigure}
  \caption{Comparison of memory layout before and after optimization.}
  \label{fig:optimization-comparison}
\end{figure}
```

## Resolution Requirements

| Output Medium | Minimum Resolution | Target Format |
|---|---|---|
| Screen (ebook/PDF) | 150 DPI | PDF (vector preferred) |
| Print (600 DPI laser) | 300 DPI | PDF (vector preferred) |
| Print (commercial offset) | 600 DPI | PDF (vector preferred) |
| Screenshots | Actual pixels (no upscaling) | PNG |

For photographs and screenshots: always include the actual capture at full resolution.
Never upscale a rasterized image. If the original is low resolution, note this in
the caption: "(Screenshot from v2.3 documentation; image quality constrained by
original source.)"

## Figure Source Files

Keep all source files:
- TikZ: `.tex` files in `figures/chNN/`
- PlantUML: `.puml` files in `figures/chNN/`
- Graphviz: `.dot` files in `figures/chNN/`
- Exported PDFs: `.pdf` files in `figures/chNN/`

Source files allow future editing. Never delete sources after export.

---

# CODE.md — Code Listing Standards

## Purpose

Defines syntax highlighting, listing format, annotation style, pseudocode,
algorithm presentation, and code caption requirements.

## Listing Requirements

Every code listing must have:
1. A caption: "Listing N.M: Description of what the code does."
2. A label: `\label{lst:descriptive-name}`
3. The language specified (for syntax highlighting).
4. Line numbers enabled.

## Language-Specific Styles

Use the styles defined in `preamble.sty`. Example usage:

```latex
\begin{lstlisting}[
  style=rust,
  caption={A minimal HTTP server using the Axum framework.},
  label={lst:axum-hello},
]
use axum::{routing::get, Router};
use std::net::SocketAddr;

#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(|| async { "Hello, world!" }));

    let addr = SocketAddr::from(([127, 0, 0, 1], 3000));
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}
\end{lstlisting}
```

## Inline Code

Use `\code{name}` macro for inline code references in prose:

- ✅ "The \code{tokio::spawn} function schedules a task on the async runtime."
- ❌ "The `tokio::spawn` function..." (raw backticks — use \code in LaTeX)

In Markdown, use backticks: "The `tokio::spawn` function..."

## Code Annotations

When explaining specific lines within a listing, use one of:

**Option A: Side comments** (for short explanations)
```rust
let listener = TcpListener::bind("0.0.0.0:8080").await?;  // (1) Bind to all interfaces
loop {
    let (socket, _) = listener.accept().await?;            // (2) Block until connection
    tokio::spawn(handle_connection(socket));                // (3) Handle concurrently
}
```

**Option B: Numbered callouts** (for complex explanations)

```latex
\begin{lstlisting}[
  style=python,
  caption={...},
  label={lst:...},
  escapechar=@,
]
def process(queue):
    while not queue.empty():       @\annotation{1}@
        item = queue.get()         @\annotation{2}@
        result = transform(item)
        output.put(result)         @\annotation{3}@
\end{lstlisting}

\begin{enumerate}
  \item Check whether the queue has items before blocking.
  \item Dequeue one item (blocks if empty, but \code{not queue.empty()} prevents this).
  \item Place the transformed result in the output queue for downstream consumers.
\end{enumerate}
```

## Pseudocode and Algorithms

For algorithms that are language-agnostic, use the `algorithm` and `algpseudocode` packages:

```latex
\begin{algorithm}[H]
\caption{Binary search}
\label{alg:binary-search}
\begin{algorithmic}[1]
\Require Sorted array $A[0..n-1]$, target value $t$
\Ensure Index $i$ such that $A[i] = t$, or $-1$ if not found
\Function{BinarySearch}{$A$, $t$}
  \State $lo \gets 0$, $hi \gets n - 1$
  \While{$lo \leq hi$}
    \State $mid \gets lo + \lfloor(hi - lo) / 2\rfloor$  \Comment{Avoids overflow}
    \If{$A[mid] = t$}
      \Return $mid$
    \ElsIf{$A[mid] < t$}
      \State $lo \gets mid + 1$
    \Else
      \State $hi \gets mid - 1$
    \EndIf
  \EndWhile
  \Return $-1$
\EndFunction
\end{algorithmic}
\end{algorithm}
```

## Terminal Sessions

Format terminal sessions with the bash style, prefixed with `$` for user commands
and no prefix for output:

```latex
\begin{lstlisting}[style=bash, caption={Installing and verifying the tool.}]
$ cargo install myapp --version 1.2.0
    Updating crates.io index
  Downloading myapp v1.2.0
   Compiling myapp v1.2.0
    Finished release [optimized] target
     Installing ~/.cargo/bin/myapp

$ myapp --version
myapp 1.2.0 (built 2024-01-15)
\end{lstlisting}
```

## Maximum Listing Length

50 lines in the main text. Longer listings go in an appendix:

```latex
% In chapter:
The complete implementation is shown in \autoref{lst:full-implementation}
(\autoref{app:code-listings}, page \pageref{lst:full-implementation}).
A minimal excerpt follows:

\begin{lstlisting}[style=rust, caption={Core loop excerpt (full listing in Appendix A).}]
// ... 15 lines maximum for the illustrative excerpt ...
\end{lstlisting}
```

---

# CITATIONS.md — Citation Workflow

## Purpose

Defines how to create, manage, validate, and format citations. Every non-trivial
claim in the documentation must carry a citation. This file is the implementation
of the accuracy policy defined in SYSTEM.md.

## BibTeX Entry Formats

### Academic Paper
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
  note      = {Introduces the Raft consensus algorithm},
}
```

### Book
```bibtex
@book{Kleppmann2017,
  author    = {Kleppmann, Martin},
  title     = {Designing Data-Intensive Applications},
  year      = {2017},
  publisher = {O'Reilly Media},
  address   = {Sebastopol, CA},
  isbn      = {978-1-4493-7332-0},
}
```

### RFC
```bibtex
@techreport{RFC8446,
  author      = {Rescorla, Eric},
  title       = {{The Transport Layer Security (TLS) Protocol Version 1.3}},
  type        = {RFC},
  number      = {8446},
  year        = {2018},
  month       = aug,
  institution = {IETF},
  url         = {https://tools.ietf.org/html/rfc8446},
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
  note    = {Accessed 15 March 2024},
}
```

### GitHub Repository
```bibtex
@misc{TokioRepo2024,
  author  = {{Tokio Contributors}},
  title   = {Tokio: An asynchronous runtime for the Rust programming language},
  year    = {2024},
  url     = {https://github.com/tokio-rs/tokio},
  urldate = {2024-03-15},
  version = {1.36.0},
}
```

## Inline Citation Style

In LaTeX, use `\cite{}` for numbered citations (IEEE style) or `\textcite{}`
for author-visible citations:

```latex
% Numbered (default for technical references):
The Raft consensus algorithm was designed for understandability \cite{Ongaro2014}.

% Author visible (for whitepapers and academic writing):
\textcite{Kleppmann2017} provides a comprehensive treatment of distributed systems.

% Multiple citations:
Several implementations exist \cite{Ongaro2014, Howard2020, Heidi2018}.
```

## Citation Validation Checklist

Before finalizing bibliography:

- [ ] Every `\cite{}` key has a corresponding entry in `references.bib`
- [ ] Every URL has been verified to be accessible
- [ ] Every DOI resolves to the correct paper
- [ ] Every RFC number is correct and the RFC has not been obsoleted
- [ ] Book ISBNs are correct
- [ ] Author names are spelled correctly (check the paper's title page)
- [ ] Venues and years are correct
- [ ] `urldate` fields reflect the actual date of access
- [ ] `biber` runs without warnings about missing fields

## Required BibTeX Fields by Entry Type

| Type | Required Fields |
|---|---|
| `@article` | author, title, journal, year, volume, number, pages |
| `@inproceedings` | author, title, booktitle, year, pages, publisher |
| `@book` | author, title, year, publisher, isbn |
| `@techreport` (RFC) | author, title, type, number, year, institution, url |
| `@online` | author, title, year, url, urldate |
| `@misc` (GitHub) | author, title, year, url, urldate, version (if applicable) |

## Inter-file Relationships

```
CITATIONS.md
    ├── RESEARCH.md        (all sources identified in research go into bibliography)
    ├── LATEX.md           (biblatex configuration in preamble.sty)
    ├── BUILD.md           (biber compilation step in the build pipeline)
    └── QUALITY.md         (citation validation checklist in QA phase)
```
