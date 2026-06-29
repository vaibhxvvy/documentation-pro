# STYLE_GUIDE.md — Complete Writing Guide

## Purpose

This file defines every stylistic decision for documentation produced by this skill.
It is the single source of truth for voice, tone, grammar, capitalization, terminology,
paragraph structure, list rules, table rules, callout boxes, cross-references,
footnotes, and common mistakes.

The Documentation Agent must consult this file whenever making a stylistic decision.
When in doubt: look it up here. If not covered here: use the most conservative option
and note the gap.

## Voice

Use **active voice** in all main text.

Active voice places the subject before the action:
- ✅ "The compiler resolves type aliases before evaluating expressions."
- ❌ "Type aliases are resolved by the compiler before expressions are evaluated."

Active voice is clearer, shorter, and places agency correctly.

Passive voice is permitted in exactly two cases:
1. When the agent is unknown or irrelevant: "The error was introduced in version 3.2."
2. When emphasizing the receiver: "The packet is dropped if the queue is full."

In all other cases, restructure to active voice.

## Tone

**Technical references**: Neutral, precise, authoritative. No humor. No personality
quirks. Write as if documenting physical laws — factual and permanent.

**Tutorials**: Warm, direct, encouraging. Use "you" and "we" appropriately. Acknowledge
that things can be confusing. Do not be condescending.

**API documentation**: Terse, complete, format-driven. Every parameter documented.
Every return value documented. Every exception documented. No prose beyond what is
necessary to disambiguate.

**Architecture documents**: Deliberate, structured, future-aware. Acknowledge design
tradeoffs. Explain what was chosen and why alternatives were rejected.

**Whitepapers**: Formal, persuasive, evidence-backed. Claims supported by citations.
No unsupported assertions.

## Person

| Document Type | Person | Example |
|---|---|---|
| Tutorial | Second person ("you") | "You configure the database connection..." |
| Reference | Third person | "The function returns an error code if..." |
| API docs | Second person | "Pass the token as a Bearer header." |
| Architecture doc | First person plural ("we") | "We chose this approach because..." |
| RFC | Impersonal / normative | "The server MUST respond within..." |
| Whitepaper | Third person | "This system achieves sub-millisecond latency..." |

## Grammar

**Oxford comma**: Always use the Oxford (serial) comma.
- ✅ "The system supports PostgreSQL, MySQL, and SQLite."
- ❌ "The system supports PostgreSQL, MySQL and SQLite."

**Em dash**: Use em dash (—) with no spaces on either side for strong interruptions.
- ✅ "The scheduler—which runs on the coordinator node—assigns tasks."
- Do not use double hyphen (--) in prose. Use `---` in Markdown, `---` in LaTeX.

**Hyphenation**: Hyphenate compound modifiers before nouns.
- ✅ "A lock-free data structure"
- ✅ "A write-ahead log"
- ✅ "An event-driven architecture"
- ❌ "The data structure is lock free" (no hyphen after verb)

**Numbers**: Spell out one through nine. Use numerals for 10 and above.
- ✅ "three replicas", "10 replicas"
- Exception: always use numerals in code, formulas, measurements, and tables.
- Exception: always use numerals when comparing a number above and below 10 in the
  same sentence: "comparing 8 and 12 replicas."

**Contractions**: Not permitted in references, specifications, or whitepapers.
Permitted in tutorials and guides: "don't", "can't", "it's" are acceptable.

**Sentence fragments**: Not permitted as body text. Permitted only as list items
when all items in the list are parallel fragments.

**Ampersand (&)**: Never use in prose. Use "and". Permitted in UI labels, code,
table column headers.

## Capitalization

**Product names**: Use the official capitalization exactly.
- ✅ "PostgreSQL" not "Postgresql" or "postgres"
- ✅ "GitHub" not "Github" or "github"
- ✅ "macOS" not "MacOS" or "macos"
- ✅ "JavaScript" not "Javascript" or "javascript"
- ✅ "TypeScript" not "Typescript"
- ✅ "gRPC" not "GRPC" or "Grpc"

**Concepts and terms**: Lowercase unless part of an official name.
- ✅ "the event loop", "a mutex", "thread safety", "the garbage collector"
- ✅ "the TCP protocol", "an HTTP request", "a REST API"
- ❌ "the Event Loop", "a Mutex", "Thread Safety"

**Section headings**: Title case for h1 chapter titles. Sentence case for h2 and h3.
- ✅ `# Understanding Distributed Consensus` (title case)
- ✅ `## How Raft achieves log replication` (sentence case)
- ❌ `## How Raft Achieves Log Replication` (title case for h2 — incorrect)

**Acronyms**: Always define at first use. Capitalize all letters of the acronym.
- ✅ "The Write-Ahead Log (WAL) records every change..."
- After definition, use "WAL" throughout.

**RFC normative keywords**: Per RFC 2119, these MUST be in all-caps when used
normatively: MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT,
RECOMMENDED, MAY, OPTIONAL.

## Technical Terminology

**Define every term at first use.** Even if you assume the reader knows it, define it.
This serves two purposes: establishes the exact meaning you intend, and serves as
reference for readers who do not know the term.

Definition format:
> A **mutex** (mutual exclusion lock) is a synchronization primitive that prevents
> concurrent access to a shared resource by allowing only one thread to hold the lock
> at any time.

After definition, use the term as defined. Do not switch between synonyms.

**Forbidden synonyms** (pick one and use it everywhere):
| Use this | Not these |
|---|---|
| repository | repo, codebase (unless specifically distinguishing) |
| function | method, procedure, routine (unless language-specific) |
| parameter | argument (unless in formal computer science context) |
| executable | binary, application, program (be consistent per document) |
| terminate | exit, quit, stop, die, crash (choose the precise term) |
| identifier | name, label, key (unless these have distinct meanings) |

## Chapter Writing Style

Chapters begin with a **chapter lead**: one to three sentences that tell the reader
exactly what they will learn and why it matters. The chapter lead is not a table of
contents. It is a motivating statement.

✅ Good chapter lead:
> This chapter explains how the Linux kernel's Completely Fair Scheduler (CFS) assigns
> CPU time to processes. Understanding CFS is essential for diagnosing latency spikes
> and tuning container workloads in production environments.

❌ Bad chapter lead:
> In this chapter, we will cover scheduling. We will look at various topics related
> to how processes get CPU time.

Every major section begins with one sentence that states what the section covers.
This is not a heading restatement. It is the first sentence of the section body.

## Paragraph Structure

Each paragraph follows this structure:
1. **Topic sentence**: States the single point of the paragraph.
2. **Support**: 2–5 sentences that develop, explain, or evidence the topic.
3. **Transition** (optional): Links to the next paragraph when not obvious.

Do not write paragraphs without topic sentences.
Do not write paragraphs that cover more than one topic.
Do not write single-sentence paragraphs except for dramatic emphasis (rare).

## List Rules

**Unordered lists**: Use when order does not matter.
**Ordered lists**: Use when order matters (steps, rankings, priorities).
**Definition lists**: Use for glossary-style definitions.

**Minimum items**: 3. If you have 2 items, write them as prose.
**Maximum items**: 7. If you have 8+ items, group into sublists or use a table.

**Parallelism**: All list items must be grammatically parallel.
- ✅ All items are noun phrases: "Thread safety", "Memory alignment", "Cache coherence"
- ✅ All items are imperative sentences: "Install the dependencies.", "Configure the environment.", "Run the tests."
- ❌ Mixed: "Thread safety", "You need to handle memory alignment", "Cache coherence"

**Punctuation**: If list items are complete sentences, end with a period. If items
are fragments, no terminal punctuation.

**Nested lists**: Maximum one level of nesting. If you need deeper nesting, restructure
into subsections.

**List introduction**: Every list must be introduced by a sentence or sentence fragment
ending in a colon.
- ✅ "The scheduler considers three factors:"
- ❌ (list with no introduction)

## Table Rules

Tables are for structured comparison of multiple attributes across multiple items.
Do not use tables for data that flows naturally as prose.

Every table must have:
- A descriptive caption (above the table in LaTeX; below in Markdown)
- A header row
- Consistent data types per column
- A label for cross-referencing (in LaTeX: `\label{tab:name}`)

See TABLES.md for specific table types (comparison, benchmark, specification, etc.)

## Callout Boxes

Use exactly these five types. No others.

### Note
General information that is useful but not critical. Does not block progress.

```
> **Note**: The default timeout is 30 seconds. This is configurable.
```

In LaTeX, use the `note` environment defined in the template.

### Warning
Information the reader must know to avoid data loss, downtime, or incorrect behavior.

```
> **Warning**: Running this command on a production database will drop all tables.
```

### Tip
A shortcut, optimization, or professional practice that improves quality or efficiency.

```
> **Tip**: Use `--dry-run` to preview changes before committing them.
```

### Important
A concept, constraint, or behavior that is frequently misunderstood and causes errors.

```
> **Important**: The `--force` flag bypasses all validation. Use it only when you
> understand the consequences.
```

### Example
A working example that illustrates the concept. Use when an inline code block would
be too disruptive to the prose flow.

```
> **Example**: A minimal configuration that enables TLS:
> ```yaml
> tls:
>   cert: /etc/certs/server.crt
>   key: /etc/certs/server.key
> ```
```

## Cross-References

Use a consistent cross-reference format throughout every document.

**Referring to a chapter**:
- ✅ "Chapter 4 covers the memory model in detail."
- ❌ "See Chapter 4." (too terse)
- ❌ "For more information about the memory model, please refer to the section about
  memory in Chapter 4 of this document." (too verbose)

**Referring to a section**:
- ✅ "The installation steps in Section 2.1 must be completed first."
- ❌ "Earlier, we discussed..." (imprecise)

**Referring to a figure**:
- ✅ "Figure 3.2 shows the sequence diagram for the handshake protocol."
- ❌ "The diagram above shows..." (breaks with layout changes)

**Referring to a table**:
- ✅ "Table 4.1 compares the throughput of each backend."

**LaTeX cross-reference format**: Always use `\ref{}` and `\autoref{}`. Never hardcode
numbers. See LATEX.md.

## Footnotes

Use footnotes sparingly. Preferred alternatives:
- For clarifications: integrate into the sentence or use a Note callout.
- For citations: use the bibliography system (CITATIONS.md).
- For asides: use a Note callout.

Footnotes are appropriate for:
1. Legal or licensing caveats
2. Highly technical asides that would disrupt flow for most readers
3. Historical context that is interesting but not essential

**Footnote style**: Complete sentences. End with a period. No formatting.

## Numbering

Chapters: Sequential integers starting from 1. Never use 0-indexed chapters in
user-facing documents (0-indexed is for API docs where it matches code).

Sections: Hierarchical decimal notation (1.1, 1.2, 2.1, 2.2). Handled automatically
by LaTeX. In Markdown, use heading levels only — do not manually add section numbers.

Figures, Tables, Equations: Chapter-prefixed sequential (Figure 3.1, Figure 3.2,
Table 3.1, Equation 3.1). Handled automatically in LaTeX with `\label` and `\ref`.

Code listings: Chapter-prefixed sequential (Listing 3.1). Use `lstlisting` with
`\label` in LaTeX. In Markdown, use bold captions above the fence: **Listing 3.1:
Description**.

## Common Mistakes

**Mistake 1: Vague quantifiers**
- ❌ "This approach is much faster."
- ✅ "This approach reduces latency by 40% under load exceeding 10,000 requests/second
  (see Table 5.2)."

**Mistake 2: Unanchored "it" and "this"**
- ❌ "The scheduler uses a red-black tree. It has O(log n) insertion time."
  (What has O(log n)? The scheduler? The red-black tree?)
- ✅ "The scheduler uses a red-black tree, which provides O(log n) insertion time."

**Mistake 3: Starting sections with definitions instead of motivation**
- ❌ "A mutex is a synchronization primitive that..."
- ✅ "When two threads access shared memory simultaneously, data corruption becomes
  possible. A mutex prevents this by..."

**Mistake 4: Orphaned acronyms**
- ❌ Using "WAL" before defining "Write-Ahead Log (WAL)"

**Mistake 5: Present tense for software behavior without version qualification**
- ❌ "The API returns 200 on success."
  (Which version? This may change.)
- ✅ "As of version 2.4, the API returns 200 on success."

**Mistake 6: "Simply", "just", "obviously", "clearly", "trivially"**
Never use these words. If something is obvious, it does not need to be said. If
it is not obvious, calling it obvious condescends to the reader.

**Mistake 7: Future tense in specifications**
- ❌ "The server will respond with a 401 status code."
- ✅ "The server responds with a 401 status code." (present tense for specification)
- ✅ "The server MUST respond with a 401 status code." (RFC-style normative)

**Mistake 8: Long chains of adjectives**
- ❌ "a high-performance, horizontally-scalable, write-optimized, distributed storage engine"
- ✅ "a distributed storage engine optimized for write throughput and horizontal scaling"

## Best Practices

1. **Read the chapter aloud** before finalizing. If a sentence is hard to say, it is
   hard to read. Rewrite it.

2. **Cut 20% after drafting.** First drafts are always too long. After completing a
   section, reduce the word count by 20% without losing information.

3. **Use concrete examples as anchors.** Introduce every abstract concept by starting
   with a concrete scenario. Define the abstraction second, not first.

4. **Test every code example.** If you cannot test it, mark it explicitly as
   "illustrative, not tested against a live environment."

5. **Write the summary before the section.** The summary should emerge naturally from
   the content. If it does not, the section does not have a clear thesis. Rewrite.

6. **Do not write placeholders.** "TODO: Add example here" is not acceptable in a
   deliverable. Either add the example or restructure to not require it.

7. **Use precise verb choices.** "executes", "invokes", "calls", "dispatches",
   "schedules", "triggers" — these are not synonyms. Use the correct one.

8. **Hedge calibration.** Know the difference between:
   - Certain: "The kernel uses a red-black tree for the CFS run queue."
   - Hedged: "Most implementations use a doubly-linked list for this purpose."
   - Speculative: "Future versions may support reactive scheduling."
   Label each category appropriately.

## References and Further Reading Sections

Every chapter ends with a **Further Reading** section. Format:

```markdown
## Further reading

**Foundational papers**

- *Title of Paper*, Author(s), Venue, Year. Brief annotation (one sentence).

**Official documentation**

- *Name of Documentation*, Organization. URL. Brief annotation.

**Books**

- *Title*, Author(s), Publisher, Year. Brief annotation.
```

Annotation length: one sentence maximum. It must tell the reader *why* to read the
resource, not what the resource is (the title does that).

## Inter-file Relationships

```
STYLE_GUIDE.md
    ├── SYSTEM.md           (source of meta-rules; STYLE_GUIDE.md implements them)
    ├── DOCUMENTATION.md    (uses style rules for chapter authoring)
    ├── CODE.md             (uses style rules for code listing captions and annotations)
    ├── TABLES.md           (uses table rules defined here)
    ├── FIGURES.md          (uses caption rules defined here)
    ├── DIAGRAMS.md         (uses caption and label rules defined here)
    └── QUALITY.md          (validates compliance with all rules in this file)
```
