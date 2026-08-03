# Committee Feedback Corrections — Implementation Plan (versão corrigida)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Address every piece of committee feedback received after the 11 June 2026 defense and produce the corrected, deposit-ready version of the dissertation (the *versão corrigida* / `definitiva`), archived under `archive/`.

**Architecture:** LaTeX thesis (`thesis.tex` + `chapters/*.tex` + `references.bib`), IME-USP template. Corrections are applied per chapter, each traced to a numbered feedback item so the mapping from feedback → edit is auditable. A final build+archive step produces the deposit PDF.

**Tech Stack:** LaTeX (`latexmk`), BibTeX/biblatex, IME-USP `imelooks`/`imegoodies` template.

**Institutional deadline:** Corrected version must be uploaded to Biblioteca Digital USP within **60 days after the defense** (defense = 11 June 2026 → deadline ≈ **10 August 2026**). See `.memory/ime-workflow.md` (Phase C).

**Hard constraint (do not violate):** Per IME rules and `.memory/writing-conventions.md`, the **deposited title must not change** after deposit. Title/abstract *framing* comments (A2) may be addressed only in the abstract body and wording, never by altering the title strings in `thesis.tex`.

---



## 1. How this plan is auditable

This plan is built so José can independently verify two things:

1. **That every feedback item was extracted correctly** — Section 2 (Feedback Registers) reproduces the **verbatim** text of every comment from both source documents, with its location (chapter/section for the txt; PDF page + the exact highlighted text for the annotations). José can open each source and confirm the quote and location match.
2. **How each item will be addressed** — every register row has a **Disposition** and a **Target** (file/section), and a **Task ref** pointing to the concrete edit in Section 4. Items that require José's input before they can be actioned are flagged **NEEDS INPUT** and consolidated in Section 3.



### Provenance of the extraction

- **Source A —** `~/Downloads/revisao hypostage.txt` (structured text review, mixed Portuguese/English). Read in full; 36 distinct comments extracted, organized under the reviewer's own headings (Comentários gerais, Título e abstract, Intro, Chapter 2–5). Likely authored by committee president Eduardo Guerra (ArchHypo TSE co-author), but the plan does not depend on author identity.
- **Source B —** `~/Downloads/JoseGoncalvesLimaNeto.pdf` (annotated PDF). All **61 annotations** authored by `melegati` (Jorge Melegati). Extracted programmatically with PyMuPDF (`fitz`), capturing annotation type, PDF page number, the note text, and the underlying highlighted text via annotation quad points. Extraction script recorded in Section 6 so the extraction itself is reproducible/auditable.

> Note on page numbers: PDF page numbers below are **physical PDF pages** (as reported by the reader), not the thesis's printed page labels. The highlighted-text snippets are copied verbatim from the extractor; where the highlight spanned a word boundary the snippet may include partial words (e.g. `rv\nr.`) — this is faithful to what the tool captured and is enough to locate the note.

---



## 2. Feedback Registers



### 2.1 Register A — `revisao hypostage.txt` (36 items)


| ID  | Location           | Verbatim (source language)                                                                                                                                                                                                                        | Interpretation                                                                                                                                           | Disposition                                                                                                        | Target                                                                                            | Task     |
| --- | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------- | -------- |
| A1  | Comentários gerais | "Definir se Corrêa (2025) vai ser introduzido como parte desse trabalho, mas de qualquer forma não é aconselhável que seja fortemnte referenciado em partes que descrevem a base da literatura."                                                  | Decide whether Corrêa (2025) is framed as part of this work; regardless, stop leaning on it as a literature-base citation.                               | **NEEDS INPUT** (framing) + reduce `\citep{correa2025}` in background/literature passages                          | `chapters/01-introduction.tex`, `chapters/02-background.tex`                                      | Q1 → T2  |
| A2  | Título e abstract  | "Tool or case study?"                                                                                                                                                                                                                             | Reader unsure if the work is a tool contribution or a case study.                                                                                        | Clarify framing in abstract (title is locked). **NEEDS INPUT** (light)                                             | `chapters/abstract.tex`                                                                           | Q2 → T3  |
| A3  | Título e abstract  | "Frase muito longa no abstract"                                                                                                                                                                                                                   | A sentence in the abstract is too long.                                                                                                                  | Split the long sentence(s) in the English + Portuguese abstract.                                                   | `chapters/abstract.tex`                                                                           | T3       |
| A4  | Intro              | "socio-technical architecture merece uma referência própria"                                                                                                                                                                                      | The socio-technical architecture claim in the intro needs its own citation.                                                                              | Add a dedicated reference where socio-technical architecture is introduced.                                        | `chapters/01-introduction.tex` (line ~25)                                                         | T4       |
| A5  | Intro              | "Corrêa (2025) developed the Hypo-Stage não parece contribuição da tese"                                                                                                                                                                          | Sentence reads as if developing Hypo-Stage is this thesis's contribution.                                                                                | Reword so Hypo-Stage's creation is clearly prior work, not this thesis's contribution.                             | `chapters/01-introduction.tex` (line ~56)                                                         | T2       |
| A6  | Intro              | "Minor: um pouco de repetição entre RQs e Objetivos"                                                                                                                                                                                              | Objectives and Research Questions overlap.                                                                                                               | Trim overlap between Objectives and RQs sections.                                                                  | `chapters/01-introduction.tex` (Objectives / RQs)                                                 | T5       |
| A7  | Chapter 2          | "2.2.1 - Seria mais preciso uma comparação com Uncertainty pq a hipotése é uma forma de registrar a incerteza."                                                                                                                                   | In §2.2.1, comparing hypothesis vs uncertainty would be more precise (hypothesis is a way to record uncertainty).                                        | Add/clarify hypothesis-vs-uncertainty relationship in Core Concepts.                                               | `chapters/02-background.tex` §subsec:archhypo-core                                                | T6       |
| A8  | Chapter 2          | "2.2.5 - Um pouco estranho se referir como IEEE Software e TSE"                                                                                                                                                                                   | §2.2.5 paragraph headers naming venues ("IEEE Software evaluation", "TSE evaluation") read oddly.                                                        | Rename the two `\paragraph` headers to describe the setting, not the venue.                                        | `chapters/02-background.tex` §subsec:archhypo-evaluations                                         | T7       |
| A9  | Chapter 2          | "2.3.1 - Internal Developer Portals (IDPs): não teria uma outra referência para fortalecer? Anjum, M. A. (2026). Platform engineering and internal developer portals: a multivocal literature review. Frontiers in Computer Science, 8, 1814498." | §2.3.1 IDP claims rely only on Corrêa; add a stronger reference (reviewer supplies Anjum 2026).                                                          | Add `anjum2026` bib entry; cite in §2.3.1 (and reuse in intro IDP mention, cf. M18).                               | `references.bib`, `chapters/02-background.tex` §subsec:idp-role                                   | T8       |
| A10 | Chapter 2          | "Sugestão: seria bom um fechamento desse capítulo com um resumo do estado atual da literatura para seu trabalho"                                                                                                                                  | Chapter 2 should end with a summary of the current state of the literature.                                                                              | Add a closing summary subsection to Chapter 2.                                                                     | `chapters/02-background.tex` (end)                                                                | T9       |
| A11 | Chapter 3          | "Not the typical related works - that usually compares the approach with others"                                                                                                                                                                  | Chapter 3 isn't a typical related-work chapter (no approach-vs-approach comparison).                                                                     | Address via framing + explicit positioning; couple with A12. **NEEDS INPUT**                                       | `chapters/03-related-work.tex`                                                                    | Q3 → T10 |
| A12 | Chapter 3          | "Talvez mudar o nome do capítulo ou reestruturar"                                                                                                                                                                                                 | Consider renaming or restructuring Chapter 3.                                                                                                            | **NEEDS INPUT** (rename and/or restructure decision).                                                              | `chapters/03-related-work.tex`, `thesis.tex` (order)                                              | Q3 → T10 |
| A13 | Chapter 4          | "Table 4.1 - Pelo texto parece que a última linha (replication) se aplica a ambos os casos"                                                                                                                                                       | In Table 4.1, the per-case "Replication logic" row reads as if replication applies to both cases (replication is a property of the pair, not each case). | Fix the "Replication logic" row (merge/reframe). Aligns with M30.                                                  | `chapters/04-research-design.tex` tab:case-comparison                                             | T11      |
| A14 | Chapter 4          | "4.4 - talvez esse acesso também possa ser usado como motivo da escolha"                                                                                                                                                                          | §4.4 (Researcher's Role): insider access could also be stated as a case-selection reason.                                                                | Add insider-access as an explicit case-selection rationale. Aligns with M28.                                       | `chapters/04-research-design.tex` §sec:case-selection / §sec:researcher-role                      | T12      |
| A15 | Chapter 4          | "4.5 - Seria interessante como Steps ou Phases... Vale uma intro com uma visão geral do processo."                                                                                                                                                | §4.5 (Procedure) would read better as explicit Steps/Phases with an overview intro.                                                                      | Add a process-overview paragraph and present the procedure as numbered phases.                                     | `chapters/04-research-design.tex` §sec:procedure                                                  | T13      |
| A16 | Chapter 4          | "4.5.2 - O nome observation não foi muito intuitivo a princípio (depois entendi) - ver como é usado em Action Research"                                                                                                                           | The "Observation Period" name is unintuitive; check how "observation" is used in Action Research.                                                        | Clarify terminology; align "observation" with action-research usage or rename subsection.                          | `chapters/04-research-design.tex` §Observation Period                                             | T13      |
| A17 | Chapter 4          | "4.5.+ - Senti falta da descrição de como as intervenções aconteciam"                                                                                                                                                                             | Missing description of how the (refinement) interventions actually happened during the study.                                                            | Describe the intervention/refinement cadence (deploy timeline). **NEEDS INPUT** (dates/mechanics).                 | `chapters/04-research-design.tex` §sec:procedure                                                  | Q7 → T14 |
| A18 | Chapter 4          | "4.6 - Patterns of use (or non-use) of Hypo-Stage during the sprint parece mais ums interpretação dos dados do que os dados coletados"                                                                                                            | The participant-observation bullet describes an interpretation, not raw collected data.                                                                  | Reword bullet (ii) to describe observed data, not interpretation.                                                  | `chapters/04-research-design.tex` §subsec:participant-observation                                 | T15      |
| A19 | Chapter 4          | "4.6 - Informal commentary - esse tem que ser melhor explicado: observação dos rituais (quais?) e dia-a-dia da equipe. Explicar melhor essa interação, talvez através do feedback da equipe."                                                     | "Informal commentary" must be explained: which rituals/ceremonies were observed and the day-to-day interaction.                                          | Expand the informal-commentary description (which ceremonies). **NEEDS INPUT** (which rituals).                    | `chapters/04-research-design.tex` §subsec:participant-observation                                 | Q6 → T15 |
| A20 | Chapter 4          | "4.6.1 - noeed more details: duration, script, etc..."                                                                                                                                                                                            | The instrument (interview/active-listening) needs more detail: duration, script, etc.                                                                    | Add session duration + reference the guide as the script. **NEEDS INPUT** (actual durations).                      | `chapters/04-research-design.tex` §subsec:active-listening, `chapters/appendix-a-instruments.tex` | Q7 → T16 |
| A21 | Chapter 4          | "(i) The number and types of hypotheses created; (ii) The quality attributes and sources of uncertainty they addressed; -> More objective data is usually analysed quantitatively."                                                               | The objective artifact data (counts, QA, sources) is usually analysed quantitatively.                                                                    | Strengthen the quantitative framing of artifact analysis (already partly present); make explicit.                  | `chapters/04-research-design.tex` §subsec:artifact-analysis, §sec:data-analysis                   | T17      |
| A22 | Chapter 5          | "-> Research Methodology Traceability: make it a section"                                                                                                                                                                                         | The "Research Methodology Traceability" block should be a numbered section.                                                                              | Convert `\section*` → numbered `\section`. Aligns with M36/M37.                                                    | `chapters/05-results-and-refinements.tex` (line ~27)                                              | T18      |
| A23 | Chapter 5          | "-> This section repeat a bit the previous chapter - I think it can just present the new information"                                                                                                                                             | The traceability section repeats Chapter 4; keep only new information.                                                                                   | Trim duplicated methodology; keep only chapter-local mapping. Aligns with M37/M38.                                 | `chapters/05-results-and-refinements.tex`                                                         | T18      |
| A24 | Chapter 5          | "Deixar claro que as hipóteses foram classificadas para mais de um NFR"                                                                                                                                                                           | Make explicit that hypotheses were classified under more than one NFR (quality attribute).                                                               | Add a sentence clarifying multi-attribute classification. Aligns with QA table note.                               | `chapters/05-results-and-refinements.tex` §subsec:qa-distribution                                 | T19      |
| A25 | Chapter 5          | "não entendi: two (H07, H08) had been validated through planning actions that predated the observation window and whose plans were registered retrospectively; and"                                                                               | The H07/H08 retrospective-registration sentence is unclear.                                                                                              | Rewrite the H07/H08 explanation clearly. Aligns with M47-area.                                                     | `chapters/05-results-and-refinements.tex` §subsec:technical-plans (line ~386)                     | T20      |
| A26 | Chapter 5          | "falsifiable statements: o que é?"                                                                                                                                                                                                                | "Falsifiable statements" needs a definition.                                                                                                             | Add a brief in-text definition/cross-ref at first use. Aligns with M-negative-formulation.                         | `chapters/05-results-and-refinements.tex` §subsec:challenges, `chapters/02-background.tex`        | T21      |
| A27 | Chapter 5          | "R3 - Are there quotes? What are the codes?"                                                                                                                                                                                                      | RQ3 results: add participant quotes and expose the codes.                                                                                                | Add verbatim quotes + surface codes/codebook. **NEEDS INPUT** (quotes availability).                               | `chapters/05-results-and-refinements.tex` §sec:rq3-results, tab:code-traceability                 | Q4 → T22 |
| A28 | Chapter 5          | "Emerging Patterns -> Candidates (solutions x challenges)"                                                                                                                                                                                        | Consider renaming "Emerging Patterns" to "Candidates" and framing as solutions × challenges.                                                             | **NEEDS INPUT** (terminology). Aligns with M43/M44.                                                                | `chapters/05-results-and-refinements.tex` §sec:emerging-patterns                                  | Q5 → T23 |
| A29 | Chapter 5          | "Não está claro o que são esses patterns... (primeira parte)"                                                                                                                                                                                     | First family (Group A) patterns are not clearly explained.                                                                                               | Add a clear definition/preamble for Group A.                                                                       | `chapters/05-results-and-refinements.tex` §sec:group-a-patterns                                   | T23      |
| A30 | Chapter 5          | "-> Missed pattern solutions"                                                                                                                                                                                                                     | Patterns lack solution components (patterns usually pair problem with solution).                                                                         | Acknowledge missing solution part (currently deferred to future work); make the deferral explicit at each pattern. | `chapters/05-results-and-refinements.tex` §sec:emerging-patterns                                  | T23      |
| A31 | Chapter 5          | "Fast-Resolution Blind Spot -> Talvez o contrário: vale a pena registrar as de longo prazo"                                                                                                                                                       | Reconsider A2 framing: perhaps the point is that long-horizon ones are worth registering (inverse framing).                                              | Reframe A2 (Fast-Resolution Blind Spot) discussion. **NEEDS INPUT** (accept reframing?).                           | `chapters/05-results-and-refinements.tex` §subsubsec:pattern-a2                                   | Q5 → T24 |
| A32 | Chapter 5          | "Na segunda parte são realmente padrões"                                                                                                                                                                                                          | Group B genuinely are patterns (positive/confirmation).                                                                                                  | No change needed; confirms Group B naming.                                                                         | —                                                                                                 | — (ack)  |
| A33 | Chapter 5          | "Context-Agnostic Restructuring Hypothesis: me parece bem específico, mas acho que essa ideia dá para ser generalizada. Hipótese para avaliar os benefícios/detalhes de uma mudança ou refactoring - Change Evaluation Hypothesis"                | B3 is too specific; generalize to a "Change Evaluation Hypothesis".                                                                                      | **NEEDS INPUT** (rename B3?).                                                                                      | `chapters/05` + `chapters/01` + `chapters/06` + `abstract` (name propagates)                      | Q5 → T25 |
| A34 | Chapter 5          | "Load-Validated Hypothesis: Maybe this is about a quality attribute that can be affected by other things and need to be monitored."                                                                                                               | B4 may really be about a monitored quality attribute affected by other factors.                                                                          | **NEEDS INPUT** (reframe/rename B4?).                                                                              | `chapters/05` (+ propagation)                                                                     | Q5 → T25 |
| A35 | Chapter 5          | "Shared Resource Governance Hypothesis: Maybe generalize to the shared resource part but governance can be one cocnern."                                                                                                                          | B5: generalize to "shared resource"; governance is just one concern.                                                                                     | **NEEDS INPUT** (reframe/rename B5?).                                                                              | `chapters/05` (+ propagation)                                                                     | Q5 → T25 |
| A36 | Chapter 5          | "-> Oportunidade: será que conseguimos classificar as hipóteses dos estudos anteriores?"                                                                                                                                                          | Opportunity: classify the hypotheses from prior ArchHypo studies with the new pattern vocabulary.                                                        | **NEEDS INPUT** (in scope for corrected version, or future work?).                                                 | `chapters/05` or `chapters/06` §future-work                                                       | Q8 → T26 |




### 2.2 Register B — `JoseGoncalvesLimaNeto.pdf` annotations (61 items, author: melegati)

Physical PDF page in `p##`. "Highlight" = text highlight with a note; "StrikeOut" = deletion mark.


| ID  | Page/type | Highlighted text (verbatim snippet)                                                                                                                                                                                   | Note (verbatim)                                                                                                                        | Interpretation                                                                                       | Disposition                                                                                             | Task                             |          |
| --- | --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | -------------------------------- | -------- |
| M1  | p11 Hi    | `y;`                                                                                                                                                                                                                  | "Period."                                                                                                                              | Replace `;` with a period.                                                                           | Copy-edit punctuation (abstract).                                                                       | T3                               |          |
| M2  | p11 Hi    | `t;`                                                                                                                                                                                                                  | "Period."                                                                                                                              | Replace `;` with a period.                                                                           | Copy-edit punctuation (abstract).                                                                       | T3                               |          |
| M3  | p11 Hi    | "a Product team of twelve engineers and a Platform team"                                                                                                                                                              | "What are product and platform teams? Probably it is a company jargon."                                                                | Define Product vs Platform team (avoid jargon).                                                      | Define terms at first use in abstract/intro; align with ch4 definitions.                                | T3/T12                           |          |
| M4  | p24 Hi    | "…falsifiable hypotheses that can be prioritized and tested through experiments (Silva, Melegati, Silveira, et al., 2025; Silva, Melegati, Wang, et al., 2024). In this context, ArchHypo is the technique that…"     | "It would be better to use other references as well."                                                                                  | Broaden citations for hypotheses engineering beyond the two Silva papers.                            | Add non-ArchHypo hypotheses-engineering refs (e.g. `melegati2019` HYPEX, Ries lean-startup, Fagerholm). | T4                               |          |
| M5  | p24 Hi    | "Empirical studies have started to explore how ArchHypo works in practice. An experience report in a software start-up describes how the technique helped the founder…"                                               | "Wrong reference?"                                                                                                                     | Verify the citation on the start-up experience report is correct (should be `silva2024ieeesw`).      | Verify/fix citation key.                                                                                | T4                               |          |
| M6  | p27 SO    | `attempts to`                                                                                                                                                                                                         | (strikeout, no text)                                                                                                                   | Delete struck words in the marked sentence.                                                          | Copy-edit (intro problem statement area).                                                               | T5                               |          |
| M7  | p28 Hi    | `hat A3`                                                                                                                                                                                                              | "Is this its name?"                                                                                                                    | Clarify the "A3" label (organizational pattern A3 reference in intro preview).                       | Clarify pattern-label usage at intro preview.                                                           | T5                               |          |
| M8  | p29 Hi    | `n chart orient`                                                                                                                                                                                                      | "I'm not sure if this word has this meaning in English."                                                                               | Word-choice check ("orient"/"orientation").                                                          | Copy-edit word choice (intro structure).                                                                | T5                               |          |
| M9  | p29 Hi    | "Research" (heading "Research Structure")                                                                                                                                                                             | "It is more about this document rather the research. Better to say Document structure, Dissertation Structure or something like this." | Rename "Research Structure" section.                                                                 | Rename `\section{Research Structure}` → "Dissertation Structure".                                       | T5                               |          |
| M10 | p29 Hi    | "Chapter 3 s…"                                                                                                                                                                                                        |                                                                                                                                        | "Maybe this chapter should come before Chapter 2."                                                   | Consider ordering Chapter 3 before Chapter 2.                                                           | **NEEDS INPUT** (chapter order). | Q3 → T10 |
| M11 | p29 Hi    | `certainties Group B s`                                                                                                                                                                                               | "What does this mean?"                                                                                                                 | The intro's forward-reference to "Group B structural patterns" is opaque before the term is defined. | Clarify/soften the forward reference in intro structure.                                                | T5                               |          |
| M12 | p32 Hi    | "…turning the software architecture into what Foote and Yoder (1999) famously characterized as a Big Ball of Mud."                                                                                                    | "No link to the reference?"                                                                                                            | The Foote & Yoder citation isn't hyperlinked/resolving.                                              | Fix `footeYoder1999` so cite resolves (see also References issues).                                     | T27                              |          |
| M13 | p32 Hi    | "Hypotheses engineering is an approach to managing technical uncertainty by formulating architectural decisions as testable hypotheses…"                                                                              | "Hypothesis Engineering is not only about architecture."                                                                               | Broaden the definition: hypotheses engineering is not architecture-specific.                         | Reword opening of §2.2 to separate hypotheses engineering (general) from ArchHypo (architecture).       | T6                               |          |
| M14 | p32 Hi    | "(DSR) and evolved from a body of patterns … conferences and through corporate training"                                                                                                                              | "It would be nice to add the original references."                                                                                     | Add original references for the DSR/patterns origin claim.                                           | Add citation(s) for ArchHypo's DSR/pattern origins.                                                     | T6                               |          |
| M15 | p35 Hi    | "to act on the"                                                                                                                                                                                                       | "to take the architectural decision?"                                                                                                  | Word choice: "act on the hypothesis" vs "take the architectural decision".                           | Copy-edit wording (§2.2.3 Architectural Trigger).                                                       | T6                               |          |
| M16 | p37 Hi    | `op *"`                                                                                                                                                                                                               | "Why the *?"                                                                                                                           | Stray `*` markdown emphasis leaked into text (P3 quote in §2.2.5).                                   | Fix stray `*` around the P3 quote.                                                                      | T7                               |          |
| M17 | p37 Hi    | `at "*`                                                                                                                                                                                                               | (no text)                                                                                                                              | Same stray `*` (closing).                                                                            | Fix stray `*`.                                                                                          | T7                               |          |
| M18 | p38 Hi    | "…converged around the concept of Internal Developer Portals (IDPs) as a platform-engineering discipline aimed at reducing this complexity while preserving team independence (Corrêa, 2025)."                        | "Are there other references for this?"                                                                                                 | IDP claim relies only on Corrêa.                                                                     | Add reference (Anjum 2026, cf. A9).                                                                     | T8                               |          |
| M19 | p40 Hi    | "Hypo-Stage: The Initial Tool"                                                                                                                                                                                        | "It would be nice to have screen shots of the tool already here so the readers know what you are talking about."                       | Add screenshot(s) of the initial tool in §2.4.                                                       | Add initial-tool screenshot figure. **NEEDS INPUT** (asset availability).                               | Q9 → T28                         |          |
| M20 | p41 Hi    | "The systematic mapping study (Souza, 2019) examined … Starting from 2,575 candidate papers, the authors applied a PICOC … NIMSAD …"                                                                                  | "No need to present so many details besides the number of analyzed studies."                                                           | Trim the Souza (2019) methodology detail.                                                            | Condense §2.5 Souza description.                                                                        | T29                              |          |
| M21 | p42 Hi    | `h o.`                                                                                                                                                                                                                | "It is strange to see such gap statements before the Related work section showing that the changes on the flow are needed."            | Gap statements appear at end of Ch2 before the related-work chapter.                                 | Reconcile with Ch2 summary (A10) and Ch3 positioning (A11/A12).                                         | T9/T10                           |          |
| M22 | p43 Hi    | "…earlier exploratory work — which included a tertiary systematic mapping study … and a multivocal literature review … and repositions those findings as narrative"                                                   | "Why wasn't it included in this dissertation?"                                                                                         | Explain why the exploratory work isn't included as full chapters.                                    | Add explanation of scope decision. **NEEDS INPUT**.                                                     | Q3 → T10                         |          |
| M23 | p45 Hi    | "ADR tools"                                                                                                                                                                                                           | "Is there a reference for this?"                                                                                                       | Add references for ADR tools (adr-tools, Log4brains).                                                | Add citation(s) for ADR tools.                                                                          | T30                              |          |
| M24 | p45 Hi    | "Architecture analysis tools"                                                                                                                                                                                         | "Reference?"                                                                                                                           | Add reference for architecture analysis tools (ATAM).                                                | Add citation(s) (e.g. ATAM/Kazman).                                                                     | T30                              |          |
| M25 | p47 Hi    | "Studies" ("Studies on architectural governance in agile organizations (e.g., … SAFe and Spotify-model variants)")                                                                                                    | "Which studies? References?"                                                                                                           | The SAFe/Spotify-model claim has no citation.                                                        | Add citation(s) or remove the unsupported bullet.                                                       | T30                              |          |
| M26 | p49 Hi    | `multiple case`                                                                                                                                                                                                       | (no text)                                                                                                                              | Mark on "multiple case" (design).                                                                    | Likely tied to M27/M29/M30 replication concerns; ensure consistent single framing.                      | T11                              |          |
| M27 | p50 Hi    | `s two cases,`                                                                                                                                                                                                        | "Multiple units of analysis??"                                                                                                         | Question whether "two cases" are cases or units of analysis (embedded design terminology).           | Clarify case vs unit-of-analysis; align terminology.                                                    | T11                              |          |
| M28 | p53 Hi    | `rv r.` (research context / case selection)                                                                                                                                                                           | "You should also mention that you chose this company because you had access to it."                                                    | State insider access as a selection reason.                                                          | Same as A14.                                                                                            | T12                              |          |
| M29 | p54 Hi    | "The two cases represent a literal replication in so far as both teams face the same intervention … and a theoretical replication in that their different scopes …"                                                   | "It should be one or another..."                                                                                                       | A pair of cases can't be both literal and theoretical replication simultaneously.                    | Resolve replication framing (choose one; likely theoretical). Aligns with A13/M30.                      | Q3? → T11                        |          |
| M30 | p54 Hi    | "Literal replication — same intervention (Hypo-Stage + ArchHypo)." (Table row)                                                                                                                                        | "A replication requires at least two cases so it does not make sense to say the replication logic of each."                            | Per-case "replication logic" in the table is conceptually wrong.                                     | Fix table row (A13) + text (M29).                                                                       | T11                              |          |
| M31 | p59 Hi    | "Explicit role separation; active search for disconfirming evidence; all claims grounded in spe-"                                                                                                                     | "How?"                                                                                                                                 | Confirmability strategies asserted without saying how.                                               | Add concrete "how" for each confirmability strategy.                                                    | T31                              |          |
| M32 | p59 Hi    | "Explicit role separation;"                                                                                                                                                                                           | "How?"                                                                                                                                 | Same as M31 (role separation mechanics).                                                             | Same.                                                                                                   | T31                              |          |
| M33 | p60 Hi    | "…the inference that hypothesis registration clustered around protected discussion time — were surfaced back to each team's senior technical leader during the active-listening sessions described in Section 4.6.3." | "This should have been mentioned earlier (probably in Section 4.6.3) and referred back here."                                          | Member-checking mechanics should be introduced in §4.6.3 and back-referenced.                        | Add member-checking description in active-listening subsection; back-reference here.                    | T16/T31                          |          |
| M34 | p60 Hi    | "Dependability … audit trail: field notes were dated and linked to specific events, artifact data were extracted and stored systematically…"                                                                          | "where and how?"                                                                                                                       | Dependability audit-trail claim needs concreteness (where/how stored).                               | Add concrete audit-trail detail. **NEEDS INPUT** (storage specifics).                                   | Q7 → T31                         |          |
| M35 | p60 Hi    | "Seeking disconfirming evidence, that is, noting instances where teams found value in the tool or the technique as readily as instances of difficulty;"                                                               | (no text)                                                                                                                              | Highlight only (endorsement/attention).                                                              | No change required.                                                                                     | —                                |          |
| M36 | p63 Hi    | "Refinements"                                                                                                                                                                                                         | (no text)                                                                                                                              | Highlight of chapter/section title.                                                                  | Tied to M37/A22 (make traceability a section).                                                          | T18                              |          |
| M37 | p63 Hi    | "Research Methodology Traceability"                                                                                                                                                                                   | "Largely a duplication of what is described in the previous chapter."                                                                  | Traceability section duplicates Ch4.                                                                 | Same as A22/A23.                                                                                        | T18                              |          |
| M38 | p65 Hi    | "Over the observation period (Hypo-Stage registrations span 11 February 2026–12 April 2026, approximately nine calendar weeks or five two-week sprints), both teams…"                                                 | "No need to repeat."                                                                                                                   | The 9-weeks/5-sprints window is repeated many times.                                                 | De-duplicate the window phrasing across §5 (state once, cross-ref).                                     | T32                              |          |
| M39 | p65 Hi    | "Across both teams, twelve of the thirteen hypotheses were authored by senior technical leaders — senior or staff engineers who held explicit architectural responsibilities…"                                        | "Is there information about the composition of the teams? How many of them are senior technical leaders?"                              | Reader wants team-composition data (how many seniors).                                               | Cross-reference §4 case table (5+7 / 2+2) at first use in §5.                                           | T33                              |          |
| M40 | p66 SO    | "…used the tool for a structured … The author suggests that…"                                                                                                                                                         | (strikeout)                                                                                                                            | Delete/soften the struck speculative sentence in §5.1.3.                                             | Copy-edit (remove struck text).                                                                         | T33                              |          |
| M41 | p71 Hi    | "During the training session and the first week of observation,"                                                                                                                                                      | "Question: are the results presented in the previous section from the whole period or just before these changes?"                      | Ambiguity: do earlier RQ results reflect the whole period or pre-refinement?                         | Clarify the temporal scope of results vs refinements.                                                   | T14/T34                          |          |
| M42 | p74 Hi    | "Figure 5.3: Evolution Chart in Hypo-Stage: tracking uncertainty and impact rating changes across successive assessments for a registered hypothesis…"                                                                | "Is this chart about a specific hypothesis? If yes, which one?"                                                                        | Identify which hypothesis the evolution chart shows (or state it's illustrative).                    | Update Fig 5.3 caption. **NEEDS INPUT** (which hypothesis / illustrative).                              | Q9 → T35                         |          |
| M43 | p74 Hi    | `listening Group A`                                                                                                                                                                                                   | "Not good names for these groups of patterns."                                                                                         | "Group A"/"Group B" are poor names.                                                                  | Rename the pattern groups. **NEEDS INPUT** (aligns with A28).                                           | Q5 → T23                         |          |
| M44 | p75 Hi    | "Patterns"                                                                                                                                                                                                            | "Are patterns the best word here?"                                                                                                     | Question the word "patterns" (esp. Group A).                                                         | Terminology decision (aligns A28/A29).                                                                  | Q5 → T23                         |          |
| M45 | p77 Hi    | "Observed evidence: Both technical leaders reported that the majority of architectural decisions encountered day-to-day were resolved before a hypothesis could be written."                                          | "These aren't recorded as ADRs either, right?"                                                                                         | Clarify these fast decisions aren't captured as ADRs either.                                         | Add a clause noting they're not captured as ADRs.                                                       | T24                              |          |
| M46 | p78 Hi    | `ader u DLT`                                                                                                                                                                                                          | "What does DLT stand for?"                                                                                                             | Expand acronym DLT (Dead Letter Topic) at first use.                                                 | Expand DLT on first use (§5).                                                                           | T36                              |          |
| M47 | p80 Hi    | "…so the garbage collector can reclaim memory, producing a healthy sawtooth heap pattern. The hypothesis remains Open because the implementation is ongoing, but the uncertainty has been effectively resolved."      | (no text)                                                                                                                              | Highlight (attention on B4 Load-Validated evidence).                                                 | Ties to A34 (B4 reframing).                                                                             | Q5 → T25                         |          |
| M48 | p82 Hi    | "kinds"                                                                                                                                                                                                               | "types?"                                                                                                                               | Word choice "kinds" → "types".                                                                       | Copy-edit.                                                                                              | T37                              |          |
| M49 | p83 Hi    | "…the falsifiability requirement continued to be described as cognitively demanding under sprint pressure, and the absence of team-visible ceremonies … emerged as a structural obstacle…"                            | "Interesting..."                                                                                                                       | Positive/attention highlight (conclusion).                                                           | No change required.                                                                                     | —                                |          |
| M50 | p84 Hi    | "RQ4"                                                                                                                                                                                                                 | "Is this a methodological contribution??"                                                                                              | Questions labeling RQ4 as a methodological contribution.                                             | Reconsider "methodological" framing of RQ4. **NEEDS INPUT** (light).                                    | Q2 → T38                         |          |
| M51 | p86 Hi    | "methodological"                                                                                                                                                                                                      | (no text)                                                                                                                              | Same as M50 (methodological framing).                                                                | Same.                                                                                                   | T38                              |          |
| M52 | p86 Hi    | "conversation"                                                                                                                                                                                                        | (no text)                                                                                                                              | Word-choice highlight ("conversation") in conclusion.                                                | Copy-edit if awkward.                                                                                   | T37                              |          |
| M53 | p88 Hi    | `): de workflow`                                                                                                                                                                                                      | "Changes to the processes, right?"                                                                                                     | Clarify "workflow" means process changes.                                                            | Copy-edit wording (conclusion/future work).                                                             | T37                              |          |
| M54 | p107 Hi   | "References" (section)                                                                                                                                                                                                | "Very few references for a master's dissertation...."                                                                                  | Overall: reference list is too short.                                                                | Increase references (satisfied cumulatively by A4/A9/M4/M14/M23/M24/M25 additions).                     | T39                              |          |
| M55 | p107 Hi   | "url: [https://arxiv.org/pdf/2309.14164.pdf](https://arxiv.org/pdf/2309.14164.pdf)" (borowa2023rationales)                                                                                                            | "Not needed but if you add the URL, use of the published version."                                                                     | Replace arXiv URL with published version (or drop URL).                                              | Fix `borowa2023rationales` (published DOI, drop arXiv).                                                 | T27                              |          |
| M56 | p107 Hi   | "doi: 10.5753/sbcars.2025.4769" (silveiraNeto2025agile)                                                                                                                                                               | "Wrong link."                                                                                                                          | DOI/link for silveiraNeto2025agile is wrong.                                                         | Verify & fix DOI. **NEEDS INPUT/verify**.                                                               | T27                              |          |
| M57 | p107 Hi   | "…in software teams". In: … Architecture (ECSA) Companion. Springer, 2017. url: [https://arxiv.org/pdf/1707.00107.pdf](https://arxiv.org/pdf/1707.00107.pdf) (dasanayake2017collaborative)"                           | "Similar as above."                                                                                                                    | Replace arXiv URL with published version.                                                            | Fix `dasanayake2017collaborative` (published DOI).                                                      | T27                              |          |
| M58 | p108 Hi   | "Maryam Razavian. Empirical research for software architecture decision making: an analysis. Journal of Systems and Software 149 (2019) … doi: 10.1016/j.jss.2018.12.013"                                             | "Wrong link and some authors are missing."                                                                                             | `razavian2019empirical` has wrong DOI and missing co-authors.                                        | Verify authors + DOI; fix.                                                                              | T27                              |          |
| M59 | p108 Hi   | "…manage architectural uncertainty. In: Proceedings of the Latin American Conference on Pattern Languages of Programming (SugarLoafPLoP). 2024. doi: 10.1145/3698322…" (silva2024patterns)                            | "Wrong conference."                                                                                                                    | The venue for silva2024patterns is wrong.                                                            | Verify correct venue; fix bib.                                                                          | T27                              |          |
| M60 | p109 Hi   | "Eduardo Silva, Jorge Melegati, Xiaofeng Wang, and Paulo Meirelles. Using hypotheses to manage technical uncertainty… IEEE Software" (silva2024ieeesw)                                                                | "Wrong authors!"                                                                                                                       | Author list for the IEEE Software paper is wrong/incomplete.                                         | Verify & fix authors of `silva2024ieeesw`.                                                              | T27                              |          |
| M61 | p109 Hi   | "…doi: 10.1109/ICSA.2017.27" (tang2017human)                                                                                                                                                                          | "Wrong link."                                                                                                                          | DOI/link for tang2017human is wrong.                                                                 | Verify & fix DOI.                                                                                       | T27                              |          |




### 2.3 Cross-source duplicates (same issue, both reviewers)

These pairs describe the same problem from both documents; addressing the linked task satisfies both:

- IDP needs a stronger reference: **A9 = M18** → T8.
- Insider access as selection reason: **A14 = M28** → T12.
- Replication logic (one-or-other; table row): **A13 = M29 = M30** → T11.
- "Research Methodology Traceability" should be a section / duplicates Ch4: **A22 = A23 = M36 = M37** → T18.
- Pattern group naming / "patterns" word: **A28 = M43 = M44** → T23.
- B-pattern generalization/renaming: **A33/A34/A35** (+ M47 evidence) → T25.
- Chapter 3 not typical / rename / order / why-excluded: **A11 = A12 = M10 = M22** → T10.

### 2.4 Register C — Author-identified during the defense presentation (2026-06-11)

Not from the two feedback documents; surfaced by José during/after the presentation. Logged here for the same audit trail.

| ID | Source | Verbatim (author's account) | Interpretation | Disposition | Task |
|----|--------|-----------------------------|----------------|-------------|------|
| C1 | Defense presentation (author) | "The perceived challenge 'Negative-formulation learning curve' particularly happened in a specific condition where the teams and the researcher decided to only create hypotheses that were **expected to be proven false**. This is **not** what the framework actually prescribes for writing hypotheses." | The study imposed a "negative-formulation" convention (only hypotheses expected to be refuted). ArchHypo instead prescribes **falsifiable** (= refutable) **simple, direct statements of the team's current belief**. The RQ3/pattern-A4 "negative-formulation" difficulty is therefore, at least partly, an **artifact of the study's own convention**, not an inherent property of ArchHypo. | Correct the conceptual description; reframe the finding; add a **construct-validity threat / transparency thread**; cite the correct definition. | **T45** (new) |

---



## 3. Decisions log (José's answers — 2026-07-04)

All input items are **RESOLVED**. Decisions below are binding for the tasks in Section 4.

- **D1 (Q1 → A1, A5):** **Prior work.** Frame the initial Hypo-Stage strictly as *prior work/background*; reduce `\citep{correa2025}` in literature-base passages and replace with primary sources. → T2
- **D2 (Q2 → A2, M50/M51):** **Both.** Clarify in the abstract that this is *a case study evaluating a tool* **and** reframe RQ4 as an **engineering/design (formative-evaluation) contribution**, not "methodological". → T3, T38
- **D3 (Q3 → A11, A12, M10, M22):** **Rename + explain.** Rename Chapter 3 (e.g. "Literature Context and Positioning") and add a framing paragraph; add 1–2 sentences explaining why the earlier exploratory work is not included as full chapters. **Do NOT reorder Ch2/Ch3** and **do NOT** add a full approach-vs-approach restructure. → T10
- **D4 (Q4 → A27):** **No usable quotes.** The active-listening sessions were genuinely open-ended and **were not recorded**; the author wrote observations from his own mental/written records. Rather than fabricate quotes, **document this explicitly as a methodological transparency thread and limitation** (no recordings, no verbatim transcripts; interpretations reconstructed from field notes and writing). Expose the codes where possible; do not add invented quotes. → T22 (revised), plus limitation in Chapter 6.
- **D5 (Q5 → A28, A29, A31, A33, A34, A35, M43, M44):** Adopt:
  - Rename the pattern **groups** to descriptive names; call **Group A** items **"candidates"** (keep Group B as patterns).
  - **A2 (Fast-Resolution Blind Spot):** invert the framing toward "the long-horizon uncertainties are the ones worth registering".
  - **B3:** rename/reframe as a **service-domain decomposition into microservices** hypothesis (a common software-architecture-evolution challenge). **Add and cite Chris Richardson, *Microservices Patterns* (Manning, 2018)** to support it — read the relevant decomposition chapters before writing.
  - **B4 (Load-Validated):** reframe as a **monitored quality-attribute** hypothesis (a QA that can be affected by other factors and must be monitored).
  - **B5 (Shared Resource Governance):** generalize to the **shared-resource** concern (governance is one facet). → T23, T24, T25
- **D6 (Q6 → A19):** Observed rituals: **daily standups, sprint planning, backlog refinement, retrospectives, dedicated architecture/technical discussions (e.g. the Kafka session), and informal (hallway/Slack/async) interaction.** → T15
- **D7 (Q7 → A17, A20, M34):** José will provide **refinement deployment dates/cadence** and **actual active-listening session durations** at execution time (insert into T14/T16). Audit-trail storage (M34): describe generically and consistently with D4 (dated written field notes + Hypo-Stage artifact exports + refinement→commit links). → T14, T16, T31
- **D8 (Q8 → A36):** **Future work only** — add retrospective classification of prior ArchHypo datasets as a future-work item. → T26
- **D9 (Q9 → M19, M42):** José **has an initial-tool screenshot** for §2.4; the **Fig 5.3 evolution chart is illustrative/representative** (caption should say so). → T28, T35
- **D10 (C1 — falsifiability correction):** The thesis currently conflates "falsifiable" with "phrased to describe what would prove it false / inverting the belief". **Correct definition (to be used and cited):**
  - Silva et al. (2024, IEEE TSE, `silva2024tse`), §V.B: an architectural hypothesis "should be **falsifiable, i.e., the possibility of proving it false exists**", and hypotheses "can be formulated as **simple and direct statements that express the current beliefs of the development team**"; the authors "**preferred to write the hypothesis more freely to reduce the friction in the adoption of the technique**." Templates with an "interrogative voice" are optional/compatible, not required.
  - Melegati & Wang (2019, IWSiB, QUESt) is the optional *template* source (Questioning/Updatable/Evaluable/Straightforward) — cite as the interrogative-template option ArchHypo says is compatible but not mandated. (TSE ref [37].)
  - Melegati, Wang & Abrahamsson (2019, RCoSE/DDrEE) is the origin of Hypotheses Engineering — cite where HE is introduced.
  - **Consequence:** the study's "only register hypotheses expected to be proven false" convention is a **deviation** from the prescribed practice; the Negative-Formulation finding (RQ3 challenge + Group-A candidate A4) must be reframed as partly an artifact of that convention, and disclosed as a **construct-validity threat / transparency thread**. → **T45** (and adjust T21, T23/A4)

---



## 4. Correction Tasks

> Convention for every task: after editing, do **not** claim done until `latexmk` builds clean (see T40). Group commits by theme using Conventional Commits (`.cursor/rules/commit-style-conventional-commits.mdc`), e.g. `docs(thesis): …` is not appropriate — use `fix(thesis)`/`refactor(thesis)`/`feat(thesis)` scopes as fitting the change. Each task lists the feedback IDs it closes.



### Task T1: Preparation & branch

**Files:** none (git only)

- [ ] **Step 1:** Create a working branch from the deposited state.

```bash
git switch -c fix/versao-corrigida-committee-feedback
```

- [ ] **Step 2:** Confirm the baseline builds before any edits (records a clean starting point).

```bash
latexmk -pdf -interaction=nonstopmode thesis.tex
```

Expected: `thesis.pdf` produced, exit code 0. If it fails, stop and fix the environment before editing.

- [ ] **Step 3:** Commit nothing yet; proceed to content tasks.

---



### Task T2: Corrêa (2025) framing (blocked by Q1) — closes A1, A5

**Files:** Modify `chapters/01-introduction.tex` (lines ~56–59, ~70, ~81, ~92, ~131, ~134), `chapters/02-background.tex` (§2.3, §2.4 Corrêa-heavy passages)

- [ ] **Step 1:** Reword the intro sentence so tool creation is prior work.

Replace (line ~56):

```latex
Grounded in these studies' contributions, \citet{correa2025} developed the Hypo-Stage, a support tool designed to help teams apply the ArchHypo technique in practice.
```

with (final wording pending Q1; default):

```latex
An initial version of Hypo-Stage --- a support tool for applying ArchHypo in practice --- was developed as prior work \citep{correa2025}; this thesis takes that tool as its starting artifact rather than as one of its contributions.
```

- [ ] **Step 2:** In `chapters/02-background.tex`, where §2.3 (Backstage/IDP) and §2.4 assertions cite only `\citep{correa2025}` for general (non-Hypo-Stage) claims, replace those with primary sources (IDP → Anjum 2026 from T8; Backstage adoption → `backstage2024`). Keep `\citep{correa2025}` only where the claim is specifically about the Hypo-Stage artifact.
- [ ] **Step 3:** Build (T40) and commit: `refactor(thesis): frame Hypo-Stage creation as prior work (A1,A5)`.

---



### Task T3: Abstract clarity + copy-edit (partly blocked by Q2) — closes A2, A3, M1, M2, M3

**Files:** Modify `chapters/abstract.tex`

- [ ] **Step 1 (A3, long sentence):** Split the long English opening sentence (lines 10–15) into two sentences at "; the ArchHypo technique addresses". Do the same for the Portuguese `\resumo` counterpart (lines 37–40).
- [ ] **Step 2 (M1, M2, "Period."):** Locate the two semicolons Melegati marked in the abstract (the clause joins around "…collaboratively;" and the later "…both augmented by…"). Replace the flagged `;` with `.` and capitalize the following word, in both languages as applicable.
- [ ] **Step 3 (M3, jargon):** On first mention of "a Product team of twelve engineers and a Platform team of four", add a short gloss, e.g. "--- a feature-delivery (Product) team and an internal-tooling (Platform) team ---" so the distinction is clear without company jargon.
- [ ] **Step 4 (A2, framing — D2):** Adjust the abstract's opening framing so it reads explicitly as *a case study evaluating and refining a tool* (do NOT touch the title strings in `thesis.tex`).
- [ ] **Step 5:** Build (T40) and commit: `fix(thesis): clarify and copy-edit abstract (A2,A3,M1,M2,M3)`.

---



### Task T4: Intro citations — socio-technical + hypotheses-engineering breadth — closes A4, M4, M5

**Files:** Modify `chapters/01-introduction.tex`, `references.bib`

- [ ] **Step 1 (A4):** At the socio-technical architecture sentence (line ~25, currently `\citep{infoq2024trends}`), add a dedicated peer-reviewed/architectural reference for socio-technical architecture (candidates: a Conway/Team-Topologies-adjacent academic source, or Herbsleb & Grinter `herbsleb1999splitting` already in bib). Prefer at least one non-gray-literature citation here.
- [ ] **Step 2 (M4):** At line ~36 ("Hypotheses Engineering has emerged … \citep{silva2024tse,silva2024ieeesw}"), add broader hypotheses-engineering references so it isn't only ArchHypo self-citation. Use `melegati2019` (HYPEX, already in bib) and add one lean-startup/experimentation source (e.g. Ries; or Fagerholm et al. "The RIGHT model for continuous experimentation"). Add the new entry to `references.bib`.
- [ ] **Step 3 (M5):** Verify the "experience report in a software start-up" (line ~42) cites `silva2024ieeesw` (IEEE Software / Catch Solve) — that is the correct start-up report. Confirm it is not mistakenly the TSE paper. Fix if wrong.
- [ ] **Step 4:** Build (T40) and commit: `fix(thesis): broaden intro citations (A4,M4,M5)`.

---



### Task T5: Intro Objectives/RQs overlap + copy-edits — closes A6, M6, M7, M8, M9, M11

**Files:** Modify `chapters/01-introduction.tex`

- [ ] **Step 1 (A6):** Reduce repetition between §Objectives (lines 84–89) and §Research Questions (lines 98–103). Keep Objectives as outcome statements and RQs as questions; remove near-duplicate phrasings (the RQ↔Objective table `tab:rq-objectives` already carries the mapping, so prose can be leaner).
- [ ] **Step 2 (M6):** Apply the struck deletion around "attempts to" in the problem-statement area (find the sentence and remove the struck words).
- [ ] **Step 3 (M7):** At the "Preview of key findings" paragraph, clarify the reference to "organizational pattern A3" — either name it ("Registration as a Slack-Dependent Practice (A3)") or defer the label until Chapter 5 defines it.
- [ ] **Step 4 (M8):** Fix the word choice flagged on "orient" in the Research Structure paragraph.
- [ ] **Step 5 (M9):** Rename the section `\section{Research Structure}` → `\section{Dissertation Structure}` (line 155).
- [ ] **Step 6 (M11):** Soften/clarify the forward reference "Group~~B structural patterns" (lines ~183) so it is intelligible before the term is defined (e.g. "recurring structural shapes of hypotheses (developed in Chapter~~\ref{chap:results})").
- [ ] **Step 7:** Build (T40) and commit: `fix(thesis): trim intro rq/objective overlap and copy-edits (A6,M6-M9,M11)`.

---



### Task T6: Chapter 2 §2.2 — hypotheses vs uncertainty, breadth, origins — closes A7, M13, M14, M15

**Files:** Modify `chapters/02-background.tex` (§sec:archhypo, §subsec:archhypo-core, §subsec:archhypo-technical-plans)

- [ ] **Step 1 (M13):** Reword the opening of §2.2 (lines 47–51) so hypotheses engineering is introduced as a *general* uncertainty-management approach, then ArchHypo as its *architecture-specific* adaptation. Avoid implying hypotheses engineering is only about architecture.
- [ ] **Step 2 (A7):** In §2.2.1 Core Concepts, add an explicit statement that an architectural hypothesis is *a way of recording/registering architectural uncertainty*, and relate the hypothesis↔uncertainty pairing (complementing the existing hypothesis-vs-risk/requirement/decision contrasts and Table `tab:hypothesis-concepts`).
- [ ] **Step 3 (M14):** Add original reference(s) for the "Grounded in DSR and evolved from a body of patterns … conferences and corporate training" claim (lines 53–56). Cite the earliest ArchHypo/agile-architecture-patterns source (`silva2024patterns` and/or the original patterns venue).
- [ ] **Step 4 (M15):** Fix wording at §2.2.3 Architectural Trigger (line ~165) "agrees to act on the hypothesis" → make explicit it means *taking/deferring the architectural decision*.
- [ ] **Step 5:** Build (T40) and commit: `fix(thesis): sharpen hypotheses-engineering framing in ch2 (A7,M13-M15)`.

---



### Task T7: Chapter 2 §2.2.5 — venue-named headers + stray asterisks — closes A8, M16, M17

**Files:** Modify `chapters/02-background.tex` (§subsec:archhypo-evaluations)

- [ ] **Step 1 (A8):** Rename the two `\paragraph` headers (lines 216, 235) from venue-named to setting-named:
  - `\paragraph{IEEE Software evaluation (Catch Solve startup).}` → `\paragraph{Start-up evaluation (Catch Solve).}`
  - `\paragraph{TSE evaluation (PropSEP at Jetsoft).}` → `\paragraph{Mission-critical evaluation (PropSEP at Jetsoft).}`
  - Keep the venue in the citation/prose, not the header.
- [ ] **Step 2 (M16, M17):** Fix the stray `*` emphasis around the P3 quote (line 286): `*''more training …''* (P3)` → use proper LaTeX emphasis: `\emph{``more training would make the team less dependent on the team of architects''} (P3)`.
- [ ] **Step 3:** Build (T40) and commit: `fix(thesis): rename evaluation headers and fix quote emphasis (A8,M16,M17)`.

---



### Task T8: IDP reference (Anjum 2026) — closes A9, M18

**Files:** Modify `references.bib`, `chapters/02-background.tex` (§subsec:idp-role), `chapters/01-introduction.tex` (if IDP mentioned)

- [ ] **Step 1:** Add the reviewer-supplied reference to `references.bib`:

```bibtex
@article{anjum2026idp,
  author  = {Anjum, Muhammad Azeem},
  title   = {Platform Engineering and Internal Developer Portals: A Multivocal Literature Review},
  journal = {Frontiers in Computer Science},
  year    = {2026},
  volume  = {8},
  pages   = {1814498},
  doi     = {10.3389/fcomp.2026.1814498}
}
```

(Verify DOI/author spelling against the Frontiers article page before finalizing.)

- [ ] **Step 2:** Add `\citep{anjum2026idp}` in §2.3.1 where IDPs are defined (lines 318–333), and at the intro IDP mention if present.
- [ ] **Step 3:** Build (T40) and commit: `feat(bib): add Anjum 2026 IDP reference (A9,M18)`.

---



### Task T9: Chapter 2 closing summary — closes A10 (and helps M21)

**Files:** Modify `chapters/02-background.tex` (end, after §sec:tooling-gap)

- [ ] **Step 1:** Add a short closing subsection, e.g. `\section{Summary: State of the Literature for This Work}`, that synthesizes what the background establishes (uncertainty management, ArchHypo mechanics, prior evaluations' limitations, IDP delivery vehicle, tooling gap) and states the resulting opening this thesis addresses. Keep it to 2–3 short paragraphs.
- [ ] **Step 2 (M21):** Ensure any "gap statement" phrasing that currently sits abruptly at the end of Ch2 (Souza tooling-void, lines 520–524) is folded into this summary so the gap is framed as a synthesis, not a stray claim before Chapter 3.
- [ ] **Step 3:** Build (T40) and commit: `feat(thesis): add ch2 literature-state summary (A10,M21)`.

---



### Task T10: Chapter 3 rename + framing + exclusion rationale (D3) — closes A11, A12, M10, M22

**Files:** Modify `chapters/03-related-work.tex`
**Decision D3:** rename + framing paragraph + exclusion explanation. **Do NOT reorder Ch2/Ch3; do NOT add a full approach-vs-approach restructure.** (M10's reorder suggestion is intentionally declined.)

- [ ] **Step 1 (A11, A12):** Change `\chapter{Related Work}` (line 3) to the agreed title — **"Literature Context and Positioning"** (adjust `\label`s only if needed; keep both existing labels to avoid breaking refs, or update all `\ref{cap:related-work}`/`\ref{chap:related-work}` if renaming labels). Add an opening paragraph stating explicitly that this chapter **positions** the work within the literature rather than performing a classic approach-vs-approach comparison, and note that the comparative element is the tool comparison in `tab:tools-comparison`.
- [ ] **Step 2 (M22):** Add 1–2 sentences (near lines 7–15) explaining *why* the earlier exploratory work (tertiary mapping + multivocal review) is repositioned as narrative context rather than included as full chapters (a deliberate scope decision to keep the thesis focused on the tool-mediated evaluation).
- [ ] **Step 3 (M10):** Since the chapter is not reordered, ensure the intro "Dissertation Structure" paragraph (T5) still describes Chapter 3 after Chapter 2 coherently, and that the new chapter title is reflected there.
- [ ] **Step 4:** Build (T40); verify no broken refs; commit: `refactor(thesis): reposition and rename related-work chapter (A11,A12,M10,M22)`.

---



### Task T11: Replication logic fix — closes A13, M26, M27, M29, M30

**Files:** Modify `chapters/04-research-design.tex` (§sec:case-selection, `tab:case-comparison` lines 226–245, replication text lines 208–224)

- [ ] **Step 1 (M29):** Rewrite lines 219–224 so the two cases are described with **one** consistent replication logic. Recommended: frame as **theoretical replication** (different scope/composition predicting contrasting findings), and drop the claim that the same pair is simultaneously a literal replication.
- [ ] **Step 2 (A13, M30):** In `tab:case-comparison`, remove/replace the per-case "Replication logic" row (a replication is a property of the case *pair*, not each case). Either delete the row and state the replication logic once in prose, or convert it to a single spanning note under the table.
- [ ] **Step 3 (M27):** Clarify "cases" vs "units of analysis": state plainly that there are two cases (two teams), each a single unit of analysis, avoiding embedded-design ambiguity.
- [ ] **Step 4:** Build (T40) and commit: `fix(thesis): correct replication logic framing (A13,M27,M29,M30)`.

---



### Task T12: Insider access as selection reason + team definitions — closes A14, M28 (and supports M3)

**Files:** Modify `chapters/04-research-design.tex` (§sec:case-selection, §sec:researcher-role, §sec:research-context)

- [ ] **Step 1 (A14, M28):** In §Case Selection (or §Research Context, lines 173–180 already mention access as an *enabling condition*), add an explicit sentence that the organization/teams were also chosen **because the researcher had insider access** to them (convenience/access as a stated purposive-selection factor).
- [ ] **Step 2 (M3):** Ensure Product vs Platform teams are defined at first use (they are, in the `\item[Team~1]`/`\item[Team~2]` descriptions and `tab:case-comparison`); add a one-line functional gloss consistent with the abstract gloss from T3.
- [ ] **Step 3:** Build (T40) and commit: `fix(thesis): state insider access as case-selection reason (A14,M28)`.

---



### Task T13: §4.5 Procedure as phases + "Observation" terminology — closes A15, A16

**Files:** Modify `chapters/04-research-design.tex` (§sec:procedure lines 271–329)

- [ ] **Step 1 (A15):** Add an overview paragraph at the start of §Procedure giving a visual/verbal overview of the process, then present the procedure as explicit numbered **Phases/Steps** (e.g. Phase 1 Training & Introduction, Phase 2 Observation & Iterative Refinement, Phase 3 Active Listening & Wrap-up).
- [ ] **Step 2 (A16):** Address the "Observation Period" naming: either rename to a clearer term or add a sentence explaining that "observation" here follows the action-research plan–act–observe–reflect cycle sense (cross-ref §Research Strategy lines 53–62), disambiguating it from mere passive watching.
- [ ] **Step 3:** Build (T40) and commit: `refactor(thesis): present procedure as phases; clarify observation term (A15,A16)`.

---



### Task T14: Describe the interventions/refinement cadence (D7) — closes A17, M41

**Files:** Modify `chapters/04-research-design.tex` (§sec:procedure), cross-ref `chapters/05-results-and-refinements.tex` §sec:refinements
**Decision D7:** José will supply the deployment dates/cadence when this task is executed — insert them here (do not leave as TODO in the final text).

- [ ] **Step 1 (A17):** Add a paragraph describing *how* interventions happened: the observe→refine→deploy→re-observe loop in concrete terms — who logged the friction, how quickly a refined Hypo-Stage version was deployed, and that refinements map to commits `ceee509 → 3a53d4e`. **Insert José's actual deployment dates/cadence (D7).**
- [ ] **Step 2 (M41):** Add a clarifying sentence resolving whether RQ1–RQ3 results reflect the whole observation window or the pre-/post-refinement state (state that results are end-of-window, cumulative, unless noted).
- [ ] **Step 3:** Build (T40) and commit: `feat(thesis): describe intervention cadence and result window (A17,M41)`.

---



### Task T15: Participant-observation wording + rituals (blocked by Q6) — closes A18, A19

**Files:** Modify `chapters/04-research-design.tex` (§subsec:participant-observation lines 362–370, and the data-collection table line 344)

- [ ] **Step 1 (A18):** Reword bullet (ii) "Patterns of use (or non-use) of Hypo-Stage during the sprint" so it names the *observed data* (e.g. "when and by whom Hypo-Stage was opened, created, or left unused during sprints") rather than an interpretation. Adjust the matching table cell (line 344) similarly.
- [ ] **Step 2 (A19):** Expand "Informal commentary" (bullet iv) to specify which rituals/ceremonies were observed (from Q6) and how the day-to-day interaction produced commentary (e.g. standups, planning, refinement, hallway/Slack discussions), optionally noting it was corroborated via team feedback.
- [ ] **Step 3:** Build (T40) and commit: `fix(thesis): clarify participant-observation data and rituals (A18,A19)`.

---



### Task T16: Active-listening instrument detail + member-checking placement (D7) — closes A20, M33

**Files:** Modify `chapters/04-research-design.tex` (§subsec:active-listening lines 389–402, §sec:trustworthiness lines 502–511), `chapters/appendix-a-instruments.tex`
**Decision D7:** José will supply the actual session durations at execution. Consistent with D4, note sessions were not recorded.

- [ ] **Step 1 (A20):** In §Active Listening, add the **actual session duration (D7)** (invitation said 20–30 min — replace with the real figure), the number of sessions (one per team's senior technical leader), a note that they were **not recorded/transcribed** (D4), and an explicit pointer that the *script* is the guide in Appendix~\ref{sec:listening-guide}.
- [ ] **Step 2 (M33):** Introduce the **member-checking** mechanic in §Active Listening (that interpretations were surfaced back to leaders for confirmation), then have §Trustworthiness back-reference it, instead of introducing it only in Trustworthiness.
- [ ] **Step 3:** Build (T40) and commit: `fix(thesis): detail active-listening instrument and member checking (A20,M33)`.

---



### Task T17: Quantitative framing of artifact analysis — closes A21

**Files:** Modify `chapters/04-research-design.tex` (§subsec:artifact-analysis lines 372–387, §sec:data-analysis lines 461–467)

- [ ] **Step 1:** Make explicit that the objective artifact data (counts, quality attributes, sources, plan strategies) are analysed **quantitatively (descriptive statistics)**, complementing the qualitative thematic coding. The text already says this at lines 461–467; add a forward-reference from §Artifact Analysis bullets (i)/(ii) so the reader sees the quantitative treatment is intentional.
- [ ] **Step 2:** Build (T40) and commit: `fix(thesis): make artifact-analysis quantitative framing explicit (A21)`.

---



### Task T18: Chapter 5 "Methodology Traceability" → section, de-duplicate — closes A22, A23, M36, M37

**Files:** Modify `chapters/05-results-and-refinements.tex` (lines 27–130)

- [ ] **Step 1 (A22, M36):** Convert `\section*{Research Methodology Traceability}` + manual `\addcontentsline` (lines 27–28) into a normal numbered `\section{Research Methodology Traceability}`.
- [ ] **Step 2 (A23, M37):** Trim the restated methodology (the data-source recap lines 35–58 and the three-stage recap lines 60–88 duplicate Chapter 4). Keep only what is *new/local*: the `tab:code-traceability` mapping and the note that the descriptive stats are chapter-local. Replace the recaps with short cross-references to Chapter 4 sections.
- [ ] **Step 3:** Build (T40) and commit: `refactor(thesis): make traceability a section and de-duplicate ch4 (A22,A23,M36,M37)`.

---



### Task T19: Multi-NFR classification clarity — closes A24

**Files:** Modify `chapters/05-results-and-refinements.tex` (§subsec:qa-distribution lines 280–321)

- [ ] **Step 1:** Add a sentence stating explicitly that a single hypothesis was frequently classified under **more than one** quality attribute (NFR), which is why the QA counts in `tab:qa-distribution` sum to more than 13 (the table caption/note already implies it via "a hypothesis may carry more than one attribute" line 285–286 — make it a highlighted sentence in prose).
- [ ] **Step 2:** Build (T40) and commit: `fix(thesis): clarify multi-NFR hypothesis classification (A24)`.

---



### Task T20: Clarify H07/H08 retrospective registration — closes A25 (relates M47)

**Files:** Modify `chapters/05-results-and-refinements.tex` (§subsec:technical-plans lines 384–388; also §pattern-b5 lines 957–963)

- [ ] **Step 1:** Rewrite the unclear sentence (lines 385–388) into plain language, e.g.: "Two hypotheses (H07, H08) were resolved by planning actions taken *before* the observation window began; their technical plans were entered into Hypo-Stage after the fact, as a record of decisions already made." Ensure consistency with the B5 evidence paragraph.
- [ ] **Step 2:** Build (T40) and commit: `fix(thesis): clarify H07/H08 retrospective registration (A25)`.

---



### Task T21: Define "falsifiable statement" — closes A26

**Files:** Modify `chapters/05-results-and-refinements.tex` (§subsec:challenges line 445+), cross-ref `chapters/02-background.tex` (§subsec:archhypo-core line 64)

- [ ] **Step 1:** At first use of "falsifiable statement" in Chapter 5, add a brief parenthetical definition and cross-reference to the §2.2.1 definition. **Use the corrected definition from T45 Step 2** (falsifiable = *the possibility of proving it false exists*; a simple, direct statement of current belief) — do **not** define it as "a statement that specifies the evidence that would prove it wrong / an inversion", which is the mis-framing T45 fixes. If T45 is done first, this task is just the cross-reference.
- [ ] **Step 2:** Build (T40) and commit: `fix(thesis): define falsifiable statement on first use (A26)`.

> Ordering note: run **T45 before T21** (and before T23/T24) so the corrected falsifiability definition is in place; T21/T23/T24 then align to it.

---



### Task T22: RQ3 transparency thread + codes (D4) — closes A27

**Files:** Modify `chapters/05-results-and-refinements.tex` (§sec:rq3-results lines 402–467; `tab:code-traceability` lines 90–124), `chapters/04-research-design.tex` (§subsec:active-listening), `chapters/06-conclusion.tex` (§sec:future-work limitations)
**Decision D4:** Do **not** add invented quotes — no verbatim material exists. Instead make the method's honesty a visible thread.

- [ ] **Step 1 (transparency, §4.6.3):** State plainly that the active-listening sessions were genuinely open-ended and **were not audio-recorded or transcribed verbatim**; the researcher reconstructed participants' perspectives from **dated field notes and post-session written recollection**. Frame this as a deliberate, low-friction choice appropriate to insider research, while acknowledging its cost.
- [ ] **Step 2 (Chapter 5 RQ3):** Where RQ3 currently implies quotable statements (e.g. "One participant noted…", lines 425–428, 458–459), keep them as **paraphrased, role-attributed observations** and add a one-line note that these are the researcher's reconstructions, not verbatim quotations.
- [ ] **Step 3 (codes):** Expose the RQ3 codes: expand or reference `tab:code-traceability` with the RQ3 codes (`registration-barrier-time-pressure`, `falsifiability-confusion`, `tool-positive-catalog-integration`) mapped to the themes, so the findings show their coding basis even without quotes.
- [ ] **Step 4 (limitation, Chapter 6):** Add to §Researcher Role and Potential Bias / limitations that the absence of recordings and verbatim transcripts is a **methodological limitation** (reliance on the researcher's note-taking and recall), and note it as a threat to confirmability that future work should address with recorded/transcribed sessions.
- [ ] **Step 5:** Build (T40) and commit: `fix(thesis): document open-listening method transparency and expose rq3 codes (A27)`.

---



### Task T23: Rename pattern groups; Group A = "candidates" (D5) — closes A28, A29, A30, M43, M44

**Files:** Modify `chapters/05-results-and-refinements.tex` (§sec:emerging-patterns lines 694–1014), and propagate names to `chapters/01-introduction.tex`, `chapters/06-conclusion.tex`, `chapters/abstract.tex`
**Decision D5:** rename the groups to descriptive names and call **Group A** items **"candidates"** (Group B stays "patterns").

- [ ] **Step 1 (A28, M43, M44):** Rename "Group A" → **"Adoption-Condition Candidates"** (candidates, not patterns) and "Group B" → **"Structural Hypothesis Patterns"**. Update the section titles (lines 725–726, 805–806), the chapter preamble (lines 19–25), and `tab:emerging-patterns` caption/labels. Throughout, refer to Group A items as *candidate conditions* rather than *patterns*.
- [ ] **Step 2 (A29):** Add a clear preamble before A1–A4 defining what the Group A candidates are: empirically grounded **candidate conditions/propositions** (not validated patterns) observed to affect adoption.
- [ ] **Step 3 (A30):** Make the *missing solution component* explicit: at the group intros and in `tab:emerging-patterns`, state that these describe problem/context only and their **solutions are deferred to future work** (reinforce the existing notes at lines 737–743, 965–970 so every item says it).
- [ ] **Step 4:** Propagate the renamed group terminology (and any renamed patterns from T24/T25) to intro (lines 133, 143–149), conclusion (lines 57–103, 253–310), and abstract (lines 27–29, 52–53). Keep `\label`s stable where possible to avoid breaking `\ref`s; if labels change, update all references.
- [ ] **Step 5:** Build (T40); verify no dangling `\ref`; commit: `refactor(thesis): rename pattern groups; group a as candidates (A28,A29,A30,M43,M44)`.

---



### Task T24: Invert A2 "Fast-Resolution Blind Spot" (D5) — closes A31, M45

**Files:** Modify `chapters/05-results-and-refinements.tex` (§subsubsec:pattern-a2 lines 761–774; `tab:emerging-patterns` A2 row lines 983–986), conclusion A2 (lines 262–267)
**Decision D5:** invert the framing.

- [ ] **Step 1 (A31):** Invert the A2 takeaway so the actionable point is that **long-horizon uncertainties are the ones worth registering** (fast-resolved micro-decisions are largely not worth the registration cost; the value is in capturing the slow, high-consequence ones). Adjust the pattern name/signature if the inverted framing warrants it, and mirror the change in the conclusion's A2 future-work bullet.
- [ ] **Step 2 (M45):** Add a clause noting these fast-resolved decisions are **not captured as ADRs either**, so the gap is genuine (not merely "unregistered in Hypo-Stage").
- [ ] **Step 3:** Build (T40) and commit: `refactor(thesis): invert fast-resolution candidate framing (A31,M45)`.

---



### Task T25: Reframe/rename structural patterns B3/B4/B5 (D5) — closes A33, A34, A35 (relates M47)

**Files:** Modify `references.bib`, `chapters/05-results-and-refinements.tex` (§subsubsec:pattern-b3/b4/b5, `tab:emerging-patterns`), propagate to `chapters/01-introduction.tex`, `chapters/06-conclusion.tex`, `chapters/abstract.tex`
**Decision D5:** B3 → service-domain decomposition into microservices (with Richardson reference); B4 → monitored quality-attribute; B5 → generalize to shared-resource.

- [ ] **Step 1 (A33 — B3 reframe + reference):** Rename **B3** "Context-Agnostic Restructuring Hypothesis" → a name reflecting **service-domain decomposition into microservices** (e.g. "**Service Decomposition Hypothesis**"). Reframe its Context/Problem as the common software-architecture-evolution challenge of decomposing a service into microservices along domain boundaries (keep the credit-bureau case as the concrete instance). **Read the relevant decomposition chapters of Chris Richardson, *Microservices Patterns* (Manning, 2018)** (esp. the "Decomposition strategies" material — decompose by business capability / by subdomain) and cite it to ground this pattern. Add to `references.bib`:

```bibtex
@book{richardson2018microservices,
  author    = {Richardson, Chris},
  title     = {Microservices Patterns: With Examples in Java},
  publisher = {Manning Publications},
  year      = {2018},
  isbn      = {9781617294549}
}
```

- [ ] **Step 2 (A34 — B4 reframe):** Reframe **B4** "Load-Validated Hypothesis" as a **monitored quality-attribute** hypothesis: a quality attribute (here, performance/scalability under load) that is affected by multiple factors and must be *continuously monitored* even after the solution is validated (M47's evidence: "uncertainty effectively resolved" yet tracked while implementation is ongoing). Rename accordingly (e.g. "**Monitored Quality-Attribute Hypothesis**") if it reads better.
- [ ] **Step 3 (A35 — B5 generalize):** Generalize **B5** from "Shared Resource **Governance** Hypothesis" to a **Shared-Resource Hypothesis** where governance (ownership, cross-domain read/write, transfer) is *one* facet among consistency/security/usability concerns.
- [ ] **Step 4:** Propagate every renamed B-pattern to intro (line 133), conclusion (lines 59–61), and abstract (lines 27–29, 52–53); update `\label`/`\ref` consistently.
- [ ] **Step 5:** Build (T40) and commit: `refactor(thesis): reframe structural patterns b3-b5 with microservices reference (A33,A34,A35)`.

---

### Task T45: Correct falsifiability framing + construct-validity threat (D10) — closes C1

**Files:** Modify `references.bib`, `chapters/02-background.tex` (§subsec:archhypo-core lines 64–82), `chapters/05-results-and-refinements.tex` (§subsec:challenges "Negative-formulation learning curve" lines 445–453; Group-A candidate A4 lines 791–802; and its `tab:emerging-patterns` A4 row lines 990–992), `chapters/04-research-design.tex` (§sec:trustworthiness / a construct-validity note), `chapters/06-conclusion.tex` (§Researcher Role and Potential Bias / limitations lines 199–208), `chapters/01-introduction.tex` (preview line 143 if it references A4)
**Decision D10.** This is the most substantive correction: the finding is not wrong, but its *cause* was mis-attributed.

- [ ] **Step 1 (bib):** Add the two authoritative sources to `references.bib`:

```bibtex
@inproceedings{melegati2019quest,
  author    = {Melegati, Jorge and Wang, Xiaofeng},
  title     = {{QUESt}: New Practices to Represent Hypotheses in Experiment-Driven Software Development},
  booktitle = {Proceedings of the 2nd ACM SIGSOFT International Workshop on Software-Intensive Business: Start-ups, Platforms, and Ecosystems (IWSiB)},
  year      = {2019},
  pages     = {13--18},
  doi       = {10.1145/3340481.3342732}
}

@inproceedings{melegati2019he,
  author    = {Melegati, Jorge and Wang, Xiaofeng and Abrahamsson, Pekka},
  title     = {Hypotheses Engineering: First Essential Steps of Experiment-Driven Software Development},
  booktitle = {IEEE/ACM Joint 4th International Workshop on Rapid Continuous Software Engineering and 1st International Workshop on Data-Driven Decisions, Experimentation and Evolution (RCoSE/DDrEE)},
  year      = {2019},
  pages     = {16--19},
  doi       = {10.1109/RCoSE/DDrEE.2019.00011}
}
```

- [ ] **Step 2 (§2.2.1 correct definition):** Correct/strengthen the architectural-hypothesis definition (line 64). State the ArchHypo prescription faithfully with citation: a hypothesis is a **falsifiable** statement — *falsifiable meaning the possibility of proving it false exists* (it is refutable/testable) — **formulated as a simple, direct statement of the team's current belief**, written freely to reduce adoption friction \citep{silva2024tse}. Note that interrogative/questioning templates (QUESt) are an **optional, compatible** representation \citep{melegati2019quest}, not a requirement, and cite the HE origin \citep{melegati2019he}. Explicitly warn against equating "falsifiable" with "must be phrased as expected-to-be-false". (This supersedes/absorbs T21's definition step — see T21.)

- [ ] **Step 3 (§5 RQ3 challenge):** Rewrite the "Negative-formulation learning curve" paragraph (lines 445–453). Keep the observed difficulty, but attribute it correctly: the difficulty arose because, **in this study, the teams and researcher adopted a convention of registering only hypotheses phrased to describe what would prove them false** — an *inversion* that ArchHypo does **not** require (it prescribes simple statements of current belief). Clarify that the cognitive cost is largely a property of the study's convention, not of ArchHypo's actual guidance.

- [ ] **Step 4 (§5 candidate A4):** Reframe "Negative-Formulation Barrier" (lines 791–802 and the `tab:emerging-patterns` A4 row) consistently: state it is conditioned on the negative-formulation convention used here; note that ArchHypo's free-form falsifiable statements may avoid it, so it is a hypothesis for future work rather than an inherent ArchHypo barrier. Reconcile with the existing claim that this "replicates" the PropSEP learning-curve finding — the *learning curve* replicates, but the *negative-formulation* framing is study-specific.

- [ ] **Step 5 (threat to validity — the "visibility" the author asked for):** Add a **construct-validity threat** in `chapters/04-research-design.tex` (§Trustworthiness/Confirmability or a dedicated threats note) and in `chapters/06-conclusion.tex` limitations: disclose that the study restricted hypothesis creation to a negative-formulation convention that deviates from ArchHypo's prescribed practice \citep{silva2024tse}, and that this deviation is a plausible cause of the Negative-Formulation finding; recommend that future studies follow the prescribed free-form falsifiable statements (optionally the QUESt template \citep{melegati2019quest}) to test whether the barrier persists.

- [ ] **Step 6:** Grep for other mentions to keep consistent:

```bash
rg -n "falsifiab|negative-formulation|Negative-Formulation|invert|prove it false|proven false" chapters/
```

Update the intro preview and abstract if they echo the old framing.

- [ ] **Step 7:** Build (T40) and commit: `fix(thesis): correct falsifiability framing; disclose negative-formulation convention as construct threat (C1)`.

---

### Task T26: Prior-studies classification as future work (D8) — closes A36

**Files:** Modify `chapters/06-conclusion.tex` §sec:future-work
**Decision D8:** future work only.

- [ ] **Step 1:** Add a bullet to the future-work agenda proposing **retrospective classification of prior ArchHypo datasets** (the 4 Catch Solve + 10 PropSEP hypotheses) with the Structural Hypothesis Patterns (former Group B) vocabulary, to test the vocabulary's reach and coverage.
- [ ] **Step 2:** Build (T40) and commit: `feat(thesis): add prior-study classification to future work (A36)`.

---



### Task T27: Bibliography corrections — closes M12, M55, M56, M57, M58, M59, M60, M61 (supports M54)

**Files:** Modify `references.bib`

For each, verify against the authoritative source (publisher page / DOI resolver `https://doi.org/<doi>`, DBLP, or the paper's official page) **before** editing; record the verified value.

- [ ] **Step 1 (M60,** `silva2024ieeesw`**):** Verify the full author list of the IEEE Software paper "Using Hypotheses to Manage Technical Uncertainty and Architecture Evolution in a Software Start-up" (DOI `10.1109/MS.2024.3383628`). Melegati flags the current list (Silva, Melegati, Wang, Meirelles) as wrong — check for missing co-authors (e.g. Guerra) and fix.
- [ ] **Step 2 (M59,** `silva2024patterns`**):** Verify the correct venue. Current bib says SugarLoafPLoP with DOI `10.1145/3698322.3698333`; Melegati says "wrong conference". Confirm the true venue/DOI and correct `booktitle`/`doi`. (Note: this key has `ids = {silva2023initialpatterns}` aliases used in Ch5 — keep the alias list intact.)
- [ ] **Step 3 (M58,** `razavian2019empirical`**):** Verify authors (Melegati: "some authors are missing") and DOI for JSS 149 (2019) 360–381. Fix author list + DOI.
- [ ] **Step 4 (M61,** `tang2017human`**):** Verify DOI for the ICSA 2017 "Human Aspects…" paper (current `10.1109/ICSA.2017.27` flagged wrong). Fix.
- [ ] **Step 5 (M56,** `silveiraNeto2025agile`**):** Verify the SBCARS 2025 DOI `10.5753/sbcars.2025.4769` (flagged wrong). Fix.
- [ ] **Step 6 (M55,** `borowa2023rationales`**; M57,** `dasanayake2017collaborative`**):** Replace the `arxiv.org/pdf/...` URLs with the **published-version** DOI/URL (ECSA 2023 / ECSA 2017 Companion). If no stable published link, keep but prefer DOI.
- [ ] **Step 7 (M12,** `footeYoder1999`**):** Ensure the Big Ball of Mud citation resolves as a hyperlink — add a `url`/`doi` or a stable reference so the in-text cite is linked. (Also verify the `\citeyearpar` usage in ch2 line 34 renders the author names correctly.)
- [ ] **Step 8:** Build (T40); check the References list renders each corrected entry; commit: `fix(bib): correct authors, venues, dois, and links (M12,M55-M61)`.

---



### Task T28: Initial-tool screenshot in §2.4 (D9) — closes M19

**Files:** Modify `chapters/02-background.tex` (§sec:hypo-stage line 405+), add image asset (José to provide the file)
**Decision D9:** José has an initial-tool screenshot.

- [ ] **Step 1:** Add José's screenshot of the **initial** Hypo-Stage version as a figure early in §2.4, with a caption clarifying it is the *initial* version (`correa2025` baseline, commit `ceee509`). Place the image in the project's figures directory used by other `\includegraphics` calls.
- [ ] **Step 2:** Build (T40) and commit: `feat(thesis): add initial hypo-stage screenshot (M19)`.

---



### Task T29: Trim Souza (2019) detail — closes M20

**Files:** Modify `chapters/02-background.tex` (§sec:tooling-gap lines 483–490)

- [ ] **Step 1:** Condense the mapping-study methodology (2,575 candidates, PICOC, 25/75 weighting, NIMSAD) to essentially the number of analyzed studies (39) and the findings that matter here. Move or drop the procedural detail.
- [ ] **Step 2:** Build (T40) and commit: `refactor(thesis): condense souza 2019 methodology detail (M20)`.

---



### Task T30: Chapter 3 missing references — closes M23, M24, M25

**Files:** Modify `references.bib`, `chapters/03-related-work.tex` (§sec:tool-support lines 127–147, §sec:empirical-studies lines 189–192)

- [ ] **Step 1 (M23):** Add reference(s) for ADR tools (e.g. Nygard's original ADR post; adr-tools / Log4brains project docs as gray literature) and cite at the ADR tools bullet.
- [ ] **Step 2 (M24):** Add a reference for architecture analysis / trade-off methods (e.g. Kazman et al. ATAM) and cite at the "Architecture analysis tools" bullet.
- [ ] **Step 3 (M25):** For "Studies on architectural governance in agile organizations (e.g., SAFe and Spotify-model variants)", either add concrete citations (e.g. `salameh2021architecture` already in bib for the Spotify model) or remove the unsupported bullet.
- [ ] **Step 4:** Build (T40) and commit: `fix(thesis): add missing references in related work (M23,M24,M25)`.

---



### Task T31: Confirmability & dependability "how" — closes M31, M32, M34

**Files:** Modify `chapters/04-research-design.tex` (§sec:trustworthiness lines 470–535; `tab:trustworthiness` lines 474–491)

- [ ] **Step 1 (M31, M32):** For each confirmability strategy ("explicit role separation", "active search for disconfirming evidence", "claims grounded in specific observations"), add a concrete *how* (e.g. how role separation was maintained in practice; how disconfirming evidence was actively logged).
- [ ] **Step 2 (M34, D7):** Make the dependability audit trail concrete and consistent with D4: state that the trail consisted of **dated written field notes** (not recordings), **artifact records exported from the Hypo-Stage database** at the end of the window, and **each refinement linked to its Hypo-Stage commit** (`ceee509 → 3a53d4e`). Insert José's storage specifics if provided.
- [ ] **Step 3:** Build (T40) and commit: `fix(thesis): make trustworthiness strategies concrete (M31,M32,M34)`.

---



### Task T32: De-duplicate the observation-window phrasing — closes M38

**Files:** Modify `chapters/05-results-and-refinements.tex` (occurrences at lines 141, 397, 713; also abstract/ch4 as needed)

- [ ] **Step 1:** State the window ("11 Feb–12 Apr 2026; ~~9 weeks / five two-week sprints") **once** in Chapter 5 (first use, line 141), and replace subsequent repetitions with a short cross-reference ("over the observation window (Section~~\ref{...})") rather than restating the full span each time.
- [ ] **Step 2:** Build (T40) and commit: `refactor(thesis): de-duplicate observation-window phrasing (M38)`.

---



### Task T33: Team-composition cross-reference + remove struck speculation — closes M39, M40

**Files:** Modify `chapters/05-results-and-refinements.tex` (§subsec:registration-dynamics lines 151–162; §subsec:adoption-patterns lines 186–194)

- [ ] **Step 1 (M39):** At the "twelve of the thirteen … senior technical leaders" sentence, add a cross-reference to the team-composition data in `tab:case-comparison` (Product: 5 senior/7 mid; Platform: 2 senior/2 mid) so the reader can see how many seniors existed.
- [ ] **Step 2 (M40):** Apply the strikeout — remove or soften the speculative sentence Melegati struck in §Tool Adoption Patterns ("The author suggests that this second wave is plausibly related … intensified commitment …", lines 187–194). Keep only what the evidence supports.
- [ ] **Step 3:** Build (T40) and commit: `fix(thesis): cross-ref team composition; remove speculation (M39,M40)`.

---



### Task T34: Result temporal-scope clarity — closes M41 (paired with T14)

**Files:** Modify `chapters/05-results-and-refinements.tex` (§sec:rq1-results intro / §sec:refinements line 476+)

- [ ] **Step 1:** Add a sentence at the start of the results (or refinements) section stating that reported RQ1–RQ3 results describe the **full observation window** (cumulative), and that refinements (RQ4) were deployed *during* that window — so results are not "pre-refinement only". (Coordinate wording with T14 Step 2 to avoid contradiction.)
- [ ] **Step 2:** Build (T40) and commit: `fix(thesis): clarify temporal scope of results vs refinements (M41)`.

---



### Task T35: Evolution-chart figure identification (D9) — closes M42

**Files:** Modify `chapters/05-results-and-refinements.tex` (`fig:evolution-chart` caption lines 608–616)
**Decision D9:** the chart is illustrative/representative.

- [ ] **Step 1:** Update the Fig 5.3 caption to state explicitly that it is an **illustrative/representative** example of the evolution chart (not tied to one specific reported hypothesis), so the reader is not left guessing which hypothesis it depicts.
- [ ] **Step 2:** Build (T40) and commit: `fix(thesis): identify evolution-chart hypothesis in caption (M42)`.

---



### Task T36: Expand DLT acronym — closes M46

**Files:** Modify `chapters/05-results-and-refinements.tex` (first DLT use — `tab:hypotheses-overview` H09 line 256, §pattern-b1 lines 866, and any earlier)

- [ ] **Step 1:** Expand "DLT" on first occurrence to "Dead Letter Topic (DLT)" (verify intended meaning; in Kafka context DLT = Dead Letter Topic/Queue), then use the acronym afterward.
- [ ] **Step 2:** Build (T40) and commit: `fix(thesis): expand DLT acronym on first use (M46)`.

---



### Task T37: Miscellaneous word-choice copy-edits — closes M48, M52, M53

**Files:** Modify `chapters/05-results-and-refinements.tex` (line ~1081 "kinds"), `chapters/06-conclusion.tex` ("conversation", "workflow")

- [ ] **Step 1 (M48):** Change "kinds" → "types" at line ~1081 ("does not name the \emph{kinds} of hypotheses").
- [ ] **Step 2 (M52):** Review the "conversation" wording flagged in the conclusion (line ~149 "contributed to the conversation about…"); rephrase if it reads too casual for the formal register.
- [ ] **Step 3 (M53):** At the flagged "workflow" mention, clarify it means **changes to the team's processes** if that is the intent.
- [ ] **Step 4:** Build (T40) and commit: `fix(thesis): word-choice copy-edits (M48,M52,M53)`.

---



### Task T38: RQ4 contribution framing (D2) — closes M50, M51

**Files:** Modify `chapters/06-conclusion.tex` (§sec:conclusion-synthesis lines 35–39, 83–94)
**Decision D2:** reframe RQ4 as an **engineering/design (formative-evaluation) contribution**, not "methodological".

- [ ] **Step 1:** Change line 37 "empirical (RQ1, RQ2, RQ3) and methodological (RQ4)" to describe RQ4 as an **engineering/design contribution — a worked instance of formative evaluation for hypothesis-engineering tools** (keep the formative-evaluation description at line 83). Ensure no other place calls RQ4 "methodological" (search `chapters/` for the term and align).
- [ ] **Step 2:** Build (T40) and commit: `fix(thesis): reframe rq4 as engineering/design contribution (M50,M51)`.

---



### Task T39: Reference-count sanity check — closes M54

**Files:** review `references.bib` after T4, T8, T27, T30

- [ ] **Step 1:** After the reference-adding tasks (T4, T8, T30) and corrections (T27), confirm the bibliography has grown and that all new entries are actually cited (no unused entries; no `\citep` to undefined keys). Melegati's "very few references" is addressed cumulatively; verify the count is reasonable for a master's dissertation.
- [ ] **Step 2:** Run a citation-integrity check:

```bash
latexmk -pdf -interaction=nonstopmode thesis.tex 2>&1 | grep -i -E "undefined|warning: citation|multiply defined" || echo "no citation warnings"
```

- [ ] **Step 3:** Commit if any bib cleanup was needed: `fix(bib): ensure all references cited and resolved (M54)`.

---



### Task T40: Build gate (run after every content task)

**Files:** none

- [ ] **Step 1:** Build and confirm zero errors:

```bash
latexmk -pdf -interaction=nonstopmode thesis.tex
```

Expected: exit 0, `thesis.pdf` regenerated. Resolve any `Undefined control sequence`, broken `\ref`, or missing-citation errors before moving on.

- [ ] **Step 2:** Skim the changed pages in `thesis.pdf` to confirm the intended visual result (tables, captions, renamed sections, resolved citations).

---



## 5. Final deposit steps (versão corrigida)

Run only after all content tasks (**T2–T39 and T45**) are complete and Section 3 decisions are applied. Follows `.memory/ime-workflow.md` Phase C and the `thesis-deposit-pdf-archive` skill.

### Task T41: Enable corrected-version front matter

**Files:** Modify `thesis.tex` (the `\tipotese` / `definitiva` toggle), verify `front-matter/banca.tex`

- [ ] **Step 1:** Enable `definitiva` in `\tipotese` in `thesis.tex` (see the comments there) so the corrected-version front matter and the `\banca{...}` committee block render. Confirm the committee roster in `front-matter/banca.tex` matches `.memory/defense-and-committee.md` (Guerra, Melegati, Valente as titulares; suplentes as listed).
- [ ] **Step 2:** Build (T40); verify the title page shows the committee block and the corrected-version designation. Do **not** change the deposited title strings.
- [ ] **Step 3:** Commit: `feat(thesis): enable definitiva front matter for corrected version`.



### Task T42: Rebuild and archive the deposit snapshot

**Files:** Add `archive/thesis-deposit-corrected-YYYYMMDD.pdf` (date = session update date)

- [ ] **Step 1:** Follow the `thesis-deposit-pdf-archive` skill: rebuild `thesis.pdf` with `latexmk` and copy it to `archive/thesis-deposit-corrected-<YYYYMMDD>.pdf` using the current session date (per the user's request to save the final version in `archive/`).

```bash
latexmk -pdf -interaction=nonstopmode thesis.tex
cp thesis.pdf "archive/thesis-deposit-corrected-$(date +%Y%m%d).pdf"
```

- [ ] **Step 2:** Commit: `chore(archive): add corrected-version deposit snapshot`.



### Task T43: Update project memory & changelog

**Files:** Modify `.memory/session-log.md`, `.memory/thesis-project.md`; add a short `docs/thesis-corrections/CHANGELOG-versao-corrigida.md` mapping feedback IDs → commits

- [ ] **Step 1:** Append a `session-log.md` entry recording the defense (11 June 2026), the two feedback sources, and that the corrected version was produced from this plan.
- [ ] **Step 2:** Update `thesis-project.md` "Current state" to reflect the corrected version and new archive artifact name.
- [ ] **Step 3:** Write a changelog listing each feedback ID (A1–A36, M1–M61, C1) and the commit(s) that addressed it — the auditable proof that every item was handled.
- [ ] **Step 4:** Commit: `docs(memory): record corrected version and feedback disposition`.



### Task T44: Upload to USP systems (manual, José)

- [ ] **Step 1:** Upload the corrected PDF to Biblioteca Digital USP / Janus within the 60-day window (deadline ≈ 10 Aug 2026). This is a manual institutional step for José. Optionally tag the repo: `git tag versao-corrigida && ...`.

---



## 6. Reproducible extraction (audit appendix)

The 61 PDF annotations in Register B were extracted with the script below (PyMuPDF). Re-running it against the source PDF reproduces the exact list, so the extraction is independently verifiable.

```python
import fitz  # pip install pymupdf
doc = fitz.open("~/Downloads/JoseGoncalvesLimaNeto.pdf")
count = 0
for pno in range(doc.page_count):
    page = doc[pno]
    annot = page.first_annot
    while annot:
        count += 1
        info = annot.info
        atype = annot.type[1]
        content = info.get("content", "")
        highlighted = ""
        verts = annot.vertices
        if verts and annot.type[0] in (8, 9, 10, 11):  # highlight/underline/squiggly/strikeout
            parts = []
            for i in range(0, len(verts), 4):
                quad = verts[i:i+4]
                if len(quad) == 4:
                    parts.append(page.get_textbox(fitz.Quad(quad).rect))
            highlighted = " ".join(t.strip() for t in parts if t.strip())
        if not highlighted.strip():
            highlighted = page.get_textbox(annot.rect)
        highlighted = " ".join(highlighted.split())
        print(f"[{count}] p{pno+1} {atype} | TEXT: {highlighted[:300]!r} | NOTE: {content!r}")
        annot = annot.next
print("TOTAL:", count)  # -> 61, all author=melegati
```

Register A was extracted by reading `~/Downloads/revisao hypostage.txt` in full (36 comments under the reviewer's own chapter headings).

---



## 7. Self-review — coverage checklist

- **Source A (txt):** All 36 comments mapped to IDs A1–A36; each has a task (A32 is an explicit "no change / confirmation").
- **Source B (pdf):** All 61 annotations mapped to IDs M1–M61; the "no note" highlights (M35, M49) are logged as no-change; all others have tasks.
- **Source C (author, defense):** C1 (falsifiability / negative-formulation correction) mapped to decision D10 and Task T45.
- **No placeholders:** every task lists exact files and concrete edits; all input items are resolved as decisions D1–D10.
- **Title constraint:** respected — only abstract wording is touched for framing (A2), never the deposited title.
- **Deposit:** T41–T44 produce the `definitiva` build, the `archive/` snapshot, memory updates, and the ID→commit changelog for full audit.
- **Ordering:** T45 (falsifiability correction) runs before T21/T23/T24 so the corrected definition propagates consistently.

