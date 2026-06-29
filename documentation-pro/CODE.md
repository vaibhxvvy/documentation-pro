# CODE.md — Code Listing Standards

## Purpose

Defines syntax highlighting, listing format, annotation style, pseudocode,
algorithm presentation, terminal session format, and code caption requirements.

## Listing Requirements

Every code listing must have:
1. A caption: "Listing N.M: Description of what the code does."
2. A label: `\label{lst:descriptive-name}`
3. The language specified for syntax highlighting.
4. Line numbers enabled.

## LaTeX Listing Format

```latex
\begin{lstlisting}[
  style=python,
  caption={Reading a CSV file and computing column statistics.},
  label={lst:ch04-csv-stats},
]
import pandas as pd

df = pd.read_csv("data.csv")
print(df.describe())
\end{lstlisting}
```

Available styles (defined in preamble.sty): `rust`, `python`, `bash`, `yaml`,
`json`, `sql`, `javascript`, `typescript`, `go`, `cpp`, `java`.

## Inline Code

In LaTeX, use `\code{name}` for inline code:
- ✅ "The \code{pd.read\_csv()} function returns a DataFrame."
- ❌ Raw backticks in LaTeX prose.

In Markdown, use backticks: "The `pd.read_csv()` function returns a DataFrame."

## Code Annotations

**Side comments** (for brief explanations):
```python
df = pd.read_csv("data.csv")   # Load into DataFrame
stats = df.describe()           # Compute count, mean, std, min, max, quartiles
print(stats.to_markdown())      # Render as Markdown table
```

**Numbered callouts** (for complex explanations — use in LaTeX):

After the listing, include a numbered list where each item explains one annotated line.

## Pseudocode (Algorithm Environment)

For language-agnostic algorithms:

```latex
\begin{algorithm}[H]
\caption{Quicksort}
\label{alg:quicksort}
\begin{algorithmic}[1]
\Require Array $A$, indices $lo$, $hi$
\Function{Quicksort}{$A$, $lo$, $hi$}
  \If{$lo < hi$}
    \State $p \gets$ \Call{Partition}{$A$, $lo$, $hi$}
    \State \Call{Quicksort}{$A$, $lo$, $p - 1$}
    \State \Call{Quicksort}{$A$, $p + 1$, $hi$}
  \EndIf
\EndFunction
\end{algorithmic}
\end{algorithm}
```

## Terminal Sessions

Prefix user commands with `$`. No prefix for output:

```bash
$ cargo build --release
   Compiling myapp v0.1.0
    Finished release [optimized] target in 3.42s

$ ./target/release/myapp --version
myapp 0.1.0
```

Style in LaTeX: use `style=bash` with no line numbers for terminal sessions
(`numbers=none` override).

## Maximum Listing Length

50 lines in main text. Longer listings go in appendices with a reference:

```
The complete implementation is in Listing A.1 (Appendix A, p. \pageref{lst:full-impl}).
A key excerpt follows:
```

## Tested vs. Illustrative Code

Mark all code that has not been run against a live environment:

```latex
\begin{lstlisting}[
  style=python,
  caption={Illustrative pseudocode only — not tested against a live environment.},
  label={lst:illustrative},
]
```

Or add a Warning callout immediately before the listing:

```latex
\begin{warningbox}
  The following listing is illustrative. It has not been tested against
  a live environment. Adapt to your specific version and configuration.
\end{warningbox}
```

## Configuration Files

For YAML, TOML, JSON, and similar config formats, use the appropriate style
and include the filename in the caption:

```latex
\begin{lstlisting}[
  style=yaml,
  caption={Minimal \filepath{config.yaml} for enabling TLS.},
  label={lst:tls-config},
]
server:
  tls:
    cert: /etc/certs/server.crt
    key: /etc/certs/server.key
    min_version: "1.3"
\end{lstlisting}
```

## Inter-file Relationships

```
CODE.md
    ├── LATEX.md           (lstset and style definitions in preamble.sty)
    ├── DOCUMENTATION.md   (Sections 6 and 7 use this file for all listings)
    └── QUALITY.md         (code correctness checklist)
```
