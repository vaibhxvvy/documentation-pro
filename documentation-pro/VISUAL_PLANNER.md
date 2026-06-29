# VISUAL_PLANNER.md — Automatic Visual Planning System

## Purpose

This module trains the Documentation Agent to decide when visuals are necessary,
which visual type to use, and how to plan diagrams before writing begins.

The agent must not write about a complex concept and then consider whether a
diagram is needed. The agent evaluates diagram need during chapter planning and
produces visuals as a required deliverable alongside prose.

## When to Load

Load this module during CHAPTER_PLAN.md completion (Section 6: Visuals Required)
and before diagram creation in DIAGRAMS.md.

Load for every publication type. Visual planning applies to all documents.

## Dependencies

```
CHAPTER_PLAN.md → VISUAL_PLANNER.md → DIAGRAMS.md
```

---

## Step 1: Visual Need Evaluation

For every chapter or major section, evaluate whether a visual would improve
comprehension. Apply this decision framework:

### Decision Framework

Answer these questions for each major section:

```
1. Does this section describe a PROCESS with defined steps?
   → Consider: Flowchart, Pipeline Diagram, Lifecycle Diagram, Swimlane Diagram

2. Does this section describe COMPONENT RELATIONSHIPS (what connects to what)?
   → Consider: Architecture Diagram, Network Diagram, Dependency Graph, Component Diagram

3. Does this section describe TIME or SEQUENCE (what happens in what order)?
   → Consider: Sequence Diagram, Timeline, State Machine

4. Does this section describe a HIERARCHY (parent-child, classification)?
   → Consider: Hierarchy Tree, Class Diagram, Taxonomy Diagram

5. Does this section describe CONDITIONAL LOGIC (if X then Y else Z)?
   → Consider: Decision Tree, Flowchart

6. Does this section describe DATA STRUCTURES or SCHEMAS?
   → Consider: ER Diagram, Class Diagram, JSON/Schema Diagram

7. Does this section COMPARE multiple options, approaches, or systems?
   → Consider: Comparison Table, Side-by-Side Diagram

8. Does this section describe a CONCEPT that is inherently spatial or relational?
   → Consider: Concept Map, Mind Map, Architecture Diagram

9. Does the section use prose to explain something that would take ONE GLANCE to grasp visually?
   → A diagram is needed.

10. Would a reader re-read this section multiple times trying to build a mental model?
    → A diagram is mandatory.
```

### Priority Classification

After evaluating, classify each potential visual:

| Priority | Meaning | Rule |
|---|---|---|
| **Essential** | The section cannot be understood without it | Must be created before writing the section |
| **Strongly Recommended** | The section is significantly clearer with it | Create unless time is critically constrained |
| **Helpful** | The section is somewhat clearer with it | Create if scope allows |
| **Optional** | Minimal comprehension benefit | Skip unless explicitly requested |

---

## Step 2: Visual Type Selection

Select the correct diagram type using this reference:

### Full Visual Type Catalog

| Visual Type | Use When | Primary Tool | Fallback |
|---|---|---|---|
| **Flowchart** | Showing algorithm or decision process | TikZ | Mermaid |
| **Sequence Diagram** | Showing message exchange between components over time | PlantUML | Mermaid |
| **State Machine** | Showing states and transitions | TikZ | PlantUML |
| **Architecture Diagram** | Showing system components and their relationships | TikZ | Draw.io |
| **Timeline** | Showing events in chronological order | TikZ | Mermaid |
| **Hierarchy Tree** | Showing parent-child relationships | TikZ | Graphviz |
| **Dependency Graph** | Showing what depends on what | Graphviz | Mermaid |
| **Pipeline Diagram** | Showing data/work flowing through stages | TikZ | Mermaid |
| **Decision Tree** | Showing branching choices and outcomes | TikZ | Graphviz |
| **Comparison Table** | Comparing options across multiple attributes | LaTeX table | Markdown table |
| **Mind Map** | Showing concept relationships around a central idea | TikZ (mindmap) | Excalidraw |
| **ER Diagram** | Showing database entity relationships | PlantUML | Graphviz |
| **Class Diagram** | Showing OOP class structure | PlantUML | Mermaid |
| **Network Diagram** | Showing network topology | TikZ | Draw.io |
| **Swimlane Diagram** | Showing process steps by actor/role | PlantUML | Mermaid |
| **Lifecycle Diagram** | Showing stages of object/system lifecycle | TikZ | Mermaid |
| **Workflow Diagram** | Showing human/system workflow | PlantUML | Mermaid |
| **Concept Map** | Showing relationships between ideas | TikZ | Excalidraw |

---

## Step 3: Per-Section Visual Plan

For each section requiring a visual, complete this form:

### Visual Specification Template

```
─────────────────────────────────────────────────────
VISUAL SPECIFICATION
─────────────────────────────────────────────────────
Figure Number:    [Figure N.M — chapter.figure]
Title:            [Descriptive title — will become the caption]
Section:          [Section number where this figure appears]
Priority:         [ ] Essential  [ ] Recommended  [ ] Helpful  [ ] Optional

Type:             [Flowchart / Sequence / Architecture / etc.]
Tool:             [TikZ / PlantUML / Graphviz / Mermaid / Table]
Output Format:    [PDF (TikZ/LaTeX) / SVG (others)]

Purpose:
  [What does this visual communicate? What understanding does it produce
  that prose cannot easily produce? 1–3 sentences.]

Content:
  Nodes/Elements: [List the components, actors, states, or entities to show]
  Connections:    [List the relationships, flows, or transitions to show]
  Labels:         [Key labels that must appear on edges or nodes]

Accessibility:
  Alt text:       [Description for screen readers — describe what the diagram shows,
                  not how it looks]
  Caption:        [Figure N.M: [Descriptive caption that explains context]]

Cross-reference in text:
  [The sentence in the prose that will reference this figure, e.g.
  "Figure 3.2 shows the request lifecycle from client to database."]

Source file:
  [figures/chNN/figure-name.tex or figure-name.puml or figure-name.dot]
─────────────────────────────────────────────────────
```

---

## Step 4: Chapter Visual Manifest

Collect all visual specifications for a chapter into a manifest:

### Visual Manifest Template

```
VISUAL MANIFEST: Chapter [N] — [Title]
════════════════════════════════════════════════════════════
Total visuals planned: [N]
Essential: [N] | Recommended: [N] | Helpful: [N] | Optional: [N]

Figure N.1: [Title] — [Type] — [Priority]
  Section: [N.X]
  Tool: [Tool]
  Source: figures/chNN/figure-name.tex

Figure N.2: [Title] — [Type] — [Priority]
  Section: [N.Y]
  Tool: [Tool]
  Source: figures/chNN/figure-name.puml

Table N.1: [Title] — [Comparison/Benchmark/Reference] — [Priority]
  Section: [N.Z]
  Format: LaTeX table / Markdown table

════════════════════════════════════════════════════════════
```

---

## Step 5: Automatic Visual Triggers

The following content patterns must trigger automatic visual creation.
When prose contains these patterns, add a visual without waiting for instruction:

### Automatic Triggers

| Content Pattern | Required Visual |
|---|---|
| "The process consists of N steps..." | Flowchart or pipeline diagram |
| "Component A communicates with Component B via..." | Architecture or sequence diagram |
| "The system transitions from state X to state Y when..." | State machine diagram |
| "There are three layers: presentation, logic, data..." | Layer/tier architecture diagram |
| "When condition A is true, do X; otherwise do Y..." | Decision tree or flowchart |
| "Table 1 compares A, B, and C across metrics..." | Comparison table |
| "The lifecycle consists of phases: create, run, stop, destroy..." | Lifecycle diagram |
| Numbered protocol or message exchange | Sequence diagram |
| "Figure [N] below shows..." (placeholder in source) | Create the actual figure |
| Any description of 5+ components and their relationships | Architecture diagram |
| Any algorithm description over 200 words | Flowchart |
| Any dependency description (A requires B requires C) | Dependency graph |

---

## Visual Consistency Standards

All visuals within a publication must conform to these consistency rules.
These complement the figure standards in FIGURES.md.

### Numbering

Format: `Figure [chapter].[sequence]` — e.g., `Figure 3.2`
Tables: `Table [chapter].[sequence]` — e.g., `Table 5.1`
Never use bare numbers. Never restart numbering mid-chapter.

### Caption Style

```
Figure N.M: [Noun phrase describing what is shown]. [Optional: one sentence
of context explaining significance or what to notice.]
```

Example:
```
Figure 3.2: Request lifecycle from client to database. Arrows indicate
direction of data flow; dashed lines indicate asynchronous operations.
```

### Style Consistency

Within a single publication:
- Use the same color palette across all diagrams (see STYLE_GUIDE.md)
- Use the same font in all diagrams
- Use the same node shape conventions throughout (e.g., rectangles = processes,
  cylinders = databases, circles = actors — define these in Chapter 1's first diagram
  and maintain them throughout)
- Box border radius: consistent (always rounded or always sharp)
- Arrow style: consistent (filled arrowhead, open arrowhead, etc.)

### Size Consistency

- All architecture diagrams: same page width fraction
- All sequence diagrams: same width
- Small reference diagrams: consistent maximum height

---

## Visual Quality Checklist

Before delivering any visual:

- [ ] Visual serves a clear, stated communicative purpose
- [ ] Diagram type matches the content type
- [ ] Output format is vector (PDF from TikZ, or SVG — no PNG for diagrams)
- [ ] Caption follows the standard format
- [ ] Figure number is correct and sequential
- [ ] Alt text is descriptive (for HTML/EPUB output)
- [ ] Fonts match the document body font (or are intentionally distinct)
- [ ] Colors are consistent with other diagrams in the chapter
- [ ] Source file is saved in `figures/chNN/` directory
- [ ] Cross-reference inserted in prose at the correct location
- [ ] Visual is readable at 100% zoom and at print size (test both)

---

## Integration with DIAGRAMS.md

This module determines WHAT to create and WHY.
DIAGRAMS.md determines HOW to create it using the selected tool.

After completing the visual manifest:
1. Load DIAGRAMS.md for the specific tool syntax and templates
2. Create each diagram per DIAGRAMS.md specifications
3. Return to this module's quality checklist to validate

---

## Related Modules

- **CHAPTER_PLAN.md** — Visual planning begins in chapter plan Section 6.
- **DIAGRAMS.md** — Implementation: syntax, templates, tool-specific rules.
- **FIGURES.md** — Placement, resolution, LaTeX inclusion rules.
- **TABLES.md** — When the visual should be a table rather than a diagram.
- **QUALITY.md** — Final visual quality checks.

---

## Version

```
Module:    VISUAL_PLANNER.md
Version:   1.0.0
Added in:  documentation-pro 2.0.0
Position:  During CHAPTER_PLAN.md and before DIAGRAMS.md
```
