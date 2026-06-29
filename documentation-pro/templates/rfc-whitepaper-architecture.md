# RFC Template

<!--
  This template follows RFC 2223 conventions.
  Fill every section. Do not leave placeholders in a final document.
  The "Abstract" must stand alone — no forward references.
-->

```
[Document title]                                         [Author(s)]
[Working Group / Organization]                           [Date: YYYY-MM]
[Category: Standards Track | Informational | Experimental | BCP]
[ISSN: 0000-0000]

Abstract

   [150–250 words. States what this document specifies and what problem
   it solves. Does not say "this document describes" — states the facts
   directly. Use present tense. No citations. No abbreviations that are
   not defined here.]

Status of This Memo

   This is an Internet Standards Track document.

   This document is a product of the [Working Group Name] Working Group
   of the Internet Engineering Task Force (IETF). It represents the
   consensus of the IETF community. It has received public review and
   has been approved for publication by the Internet Engineering
   Steering Group (IESG). Further information on Internet Standards is
   available in Section 2 of RFC 7841.

   Information about the current status of this document, any errata,
   and how to provide feedback on it may be obtained at
   https://www.rfc-editor.org/info/rfcXXXX.

Copyright Notice

   Copyright (c) [YEAR] IETF Trust and the persons identified as the
   document authors. All rights reserved.

Table of Contents

   1. Introduction ................................................ X
   2. Requirements Notation ....................................... X
   3. Definitions ................................................. X
   4. [Core specification section] ............................... X
   5. [Additional specification sections] ........................ X
   N-2. Security Considerations .................................. X
   N-1. IANA Considerations ...................................... X
   N.   References ............................................... X
        N.1. Normative References ................................ X
        N.2. Informative References .............................. X
   Acknowledgments ................................................ X
   Authors' Addresses ............................................. X

1.  Introduction

   [Background. What problem does this specification solve? What is
   the scope of this document? What is explicitly out of scope?
   Keep this section descriptive, not normative.]

2.  Requirements Notation

   The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL
   NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED",
   "MAY", and "OPTIONAL" in this document are to be interpreted as
   described in BCP 14 [RFC2119] [RFC8174] when, and only when, they
   appear in all capitals, as shown here.

3.  Definitions

   [Define all terms used normatively in this document. Alphabetical
   order. Each definition is a complete sentence.]

   Term:  [Definition. Complete sentence ending with a period.]

   Another Term:  [Definition.]

4.  [Core Specification Section]

   [Write normative specification language using MUST/SHOULD/MAY.
   Be precise. Every normative statement must be testable.]

N-2.  Security Considerations

   [REQUIRED — every RFC must have this section.]

   [Describe the security properties this specification provides.
   Explicitly state what threats it does NOT protect against.
   Describe any known attacks against this protocol or format.
   Reference relevant CVEs or security analyses if available.]

N-1.  IANA Considerations

   [Describe any IANA registry entries required by this specification.
   If none: "This document has no IANA actions."]

N.  References

N.1.  Normative References

   [RFC2119]  Bradner, S., "Key words for use in RFCs to Indicate
              Requirement Levels", BCP 14, RFC 2119,
              DOI 10.17487/RFC2119, March 1997,
              <https://www.rfc-editor.org/info/rfc2119>.

N.2.  Informative References

   [Add informative references here.]

Acknowledgments

   [Thank contributors, reviewers, and the working group.]

Authors' Addresses

   [Name]
   [Organization]
   Email: [email]
```

---

# Whitepaper Template

<!--
  Whitepapers are persuasive technical documents. Every claim is backed
  by evidence. Structure: problem → solution → evidence → conclusion.
-->

## [Title]: [Subtitle]

**Authors**: [Name(s)], [Organization]
**Date**: [Month Year]
**Version**: [X.Y]

---

### Executive Summary

[200–400 words. State the problem, the proposed solution, the key evidence,
and the conclusion. Written for a reader who will read only this section.
No technical jargon that is not immediately defined. No citations needed here —
this is a summary of what follows.]

---

### 1. Problem Statement

[Define the problem precisely. Who is affected? What is the current state?
What are the consequences of not solving it? Quantify wherever possible.
All quantitative claims must be cited.]

---

### 2. Background

[Provide the technical context a reader needs to understand the solution.
Assume the reader is a technically literate peer, not a domain expert.
Define all domain-specific terms.]

---

### 3. Proposed Solution

[Describe the solution clearly. Include:
- What it does (mechanism)
- How it addresses each element of the problem statement
- Architecture or design overview with diagram
- Key implementation details]

```
[Architecture diagram goes here — see DIAGRAMS.md]
```

---

### 4. Evidence

[Present evidence that the solution works. Use:
- Benchmark results (with full methodology — see TABLES.md)
- Case studies
- Formal proofs (if applicable)
- Comparative analysis against alternatives]

All numerical claims in this section require citations.

---

### 5. Alternatives Considered

[For each major alternative:]

#### Alternative A: [Name]

**Description**: [What it is.]
**Why rejected**: [Specific, technical reasons with evidence.]

---

### 6. Risks and Limitations

[Honest assessment of what the solution does not address, known failure modes,
scaling limits, or conditions under which it performs poorly.]

---

### 7. Conclusion

[Restate the problem. Summarize the solution. State the key evidence.
Make a clear recommendation. One to three paragraphs.]

---

### References

[Full bibliography. See CITATIONS.md for format.]

---

# Architecture Document Template

**Document**: [System Name] Architecture
**Authors**: [Names and roles]
**Status**: Draft | Under Review | Approved | Superseded
**Date**: [YYYY-MM-DD]
**Version**: [X.Y]
**Reviewers**: [Names]

---

## 1. Executive Summary

[200–400 words. What system is this? What problem does it solve? What are
the key architectural decisions? Who needs to read this document and why?]

---

## 2. Problem Statement

### 2.1 Context

[What is the business or technical context driving this design?]

### 2.2 Requirements

**Functional requirements** (what the system must do):
- [FR-1]: [Requirement]
- [FR-2]: [Requirement]

**Non-functional requirements** (quality attributes):
- [NFR-1 Performance]: [Specific measurable target, e.g., "P99 latency < 100ms at 10,000 req/s"]
- [NFR-2 Availability]: [e.g., "99.9% uptime (< 8.7 hours downtime/year)"]
- [NFR-3 Scalability]: [e.g., "Must support 10× current load without re-architecture"]

### 2.3 Constraints

[What constraints is the design operating under? Technology choices, team skills,
budget, timeline, regulatory requirements?]

---

## 3. Goals and Non-Goals

**Goals** (what this design achieves):
- [Goal 1]
- [Goal 2]

**Non-goals** (explicitly out of scope — prevents scope creep):
- [Non-goal 1]: [Why it is explicitly excluded]
- [Non-goal 2]

---

## 4. Proposed Architecture

### 4.1 System Context

[How does this system fit into the broader ecosystem? What external systems
does it interact with? Draw a context diagram.]

```
[System context diagram — see DIAGRAMS.md]
```

### 4.2 Component Design

[Describe each major component: what it does, what it owns, what its interface is.]

```
[Component diagram — see DIAGRAMS.md]
```

| Component | Responsibility | Technology |
|---|---|---|
| [Name] | [What it does] | [Stack/language] |

### 4.3 Data Flow

[How does data move through the system? Describe the critical paths.]

```
[Data flow diagram — see DIAGRAMS.md]
```

### 4.4 API Contracts

[Define the interfaces between components. This does not need to be full
API documentation — that lives elsewhere. Capture the contract between major
components: format, protocol, guarantees, error behavior.]

### 4.5 Data Model

[What data does the system store? What is the schema? What are the consistency
and durability requirements?]

### 4.6 Deployment Architecture

[Where does the system run? How is it deployed? How is it monitored?]

---

## 5. Alternatives Considered

### Alternative A: [Name]

**Description**: [Brief description of the alternative approach.]
**Pros**: [Genuine advantages.]
**Cons**: [Genuine disadvantages.]
**Decision**: Rejected because [specific technical reason].

---

## 6. Risks and Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| [Risk description] | High/Med/Low | High/Med/Low | [How it is mitigated] |

---

## 7. Implementation Plan

| Phase | Scope | Owner | Target Date |
|---|---|---|---|
| 1 | [What is built in Phase 1] | [Team/person] | [Date] |

---

## 8. Open Questions

[Questions that remain unresolved at the time of writing. Each question should
include who is responsible for resolving it and by when.]

1. [Question] — Owner: [Name] — Due: [Date]

---

## 9. References

[Bibliography — see CITATIONS.md for format.]
