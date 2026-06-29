# FIGURES.md — Figure Standards

## Purpose

Defines captions, placement, resolution, numbering, and quality standards for
all figures (diagrams, screenshots, illustrations, charts).

## Caption Requirements

Every figure must have a caption. The caption must include:
1. **What** the figure shows (not its title — its content).
2. **Context** that is not obvious from looking at the figure alone.
3. **Source** if the figure is adapted from another work (with citation).

Format: [What is shown]. [Context or interpretation]. [Source, if applicable].

Examples:
- ✅ "The Raft leader election process. A node becomes a candidate when its election
  timeout expires without receiving a heartbeat. After receiving votes from a majority,
  it becomes the leader."
- ❌ "Figure 3.2: Raft election." (too terse)

## Placement

In LaTeX, use `[H]` (requires `float` package) for most figures.
Use `[ht]` for figures that can float to top. Use `[p]` for full-page figures.
Never use bare `[h]` — LaTeX sometimes ignores it.

```latex
\begin{figure}[H]
  \centering
  \includegraphics[width=0.9\textwidth]{figures/ch02/architecture.pdf}
  \caption{Caption text here.}
  \label{fig:ch02-architecture}
\end{figure}
```

## Side-by-Side Figures

```latex
\begin{figure}[H]
  \centering
  \begin{subfigure}[b]{0.45\textwidth}
    \centering
    \input{figures/ch03/before}
    \caption{Before optimization.}
    \label{fig:before}
  \end{subfigure}
  \hfill
  \begin{subfigure}[b]{0.45\textwidth}
    \centering
    \input{figures/ch03/after}
    \caption{After optimization.}
    \label{fig:after}
  \end{subfigure}
  \caption{Memory layout comparison before and after cache-line alignment.}
  \label{fig:optimization-comparison}
\end{figure}
```

## Resolution Requirements

| Output Medium | Minimum Resolution | Target Format |
|---|---|---|
| Screen PDF | 150 DPI | PDF (vector preferred) |
| Print 600 DPI | 300 DPI | PDF (vector preferred) |
| Commercial print | 600 DPI | PDF (vector preferred) |
| Screenshots | Actual pixels (no upscaling) | PNG |

Never upscale a rasterized image. If the original is low resolution, note this in
the caption.

## Figure Width Guidelines

```latex
\includegraphics[width=\textwidth]{...}         % Full text width
\includegraphics[width=0.9\textwidth]{...}      % Most figures
\includegraphics[width=0.6\textwidth]{...}      % Narrow diagrams
\includegraphics[width=0.45\textwidth]{...}     % Side-by-side
```

## Naming Convention

```
figures/
  ch01/
    fig01-system-overview.tex       (TikZ source)
    fig02-request-flow.puml         (PlantUML source)
    fig02-request-flow.pdf          (exported for LaTeX)
```

Label format: `\label{fig:ch01-system-overview}` — always include chapter prefix.

## Alt Text for Accessibility

For HTML exports, every figure requires alt text that describes the figure content
for screen readers. In Markdown:

```markdown
![Diagram showing the Raft leader election process with three nodes labeled
  Follower, Candidate, and Leader, connected by arrows representing vote
  requests and heartbeat messages.](figures/ch02/raft-election.svg)
```

Alt text must be descriptive enough for a blind reader to understand the concept.
"Diagram of Raft election" is not sufficient.

## Source File Preservation

Keep all source files (`.tex`, `.puml`, `.dot`, `.svg`). Never delete sources
after generating exports. Future updates require the source.

## Inter-file Relationships

```
FIGURES.md
    ├── DIAGRAMS.md    (diagram files are a subset of figures)
    ├── LATEX.md       (figure package configuration in preamble.sty)
    ├── BUILD.md       (diagram rendering in build pipeline)
    └── QUALITY.md     (figure quality checklist)
```
