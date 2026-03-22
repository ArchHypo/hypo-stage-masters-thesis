# Evaluating and Refining Arch-Stage: Supporting Architectural Hypotheses in Software Engineering Teams

Master's thesis in Computer Science at **IME-USP** (Institute of Mathematics and Statistics, University of São Paulo).

| | |
|---|---|
| **Author** | José Gonçalves Lima Neto |
| **Advisor** | Prof. Dr. Paulo Roberto Miranda Meirelles |
| **Program** | Graduate Program in Computer Science — IME-USP |
| **Year** | 2026 |

## Read the Thesis

The latest compiled PDF is available directly in the repository root: **[thesis.pdf](thesis.pdf)**.

## About

This thesis empirically evaluates and refines **[Arch-Stage](https://github.com/ArchHypo/hypo-stage)**, a support tool for the **ArchHypo** technique, by applying it with multiple software engineering teams working on a scaled software product in a real-world organization. The research assesses how Arch-Stage supports managing architectural uncertainty and uses the findings to inform the tool's improvement.

## Template

This repository is based on the [IME-USP LaTeX template](https://github.com/ccsl-usp/modelo-latex) (`ccsl-usp/modelo-latex`) by Jesús P. Mena-Chalco, Fabio Kon, Paulo Feofiloff, and Nelson Lago.

## Context and Lineage

### Qualification Work

The author's qualification research (December 2024) explored centralization vs. decentralization of software architecture decision-making through a systematic mapping study and a multivocal literature review. The committee recommended narrowing the scope to specific teams and a concrete artifact.

### ArchHypo

The **ArchHypo** technique (Silva et al., [IEEE Software 2024](https://doi.org/10.1109/MS.2024.3383628), [TSE 2025](https://doi.org/10.1109/TSE.2024.3520477)) uses hypotheses engineering to manage software architecture uncertainty. Prior evaluations demonstrated its value but highlighted significant adoption barriers — particularly the learning curve and cognitive load of manual application.

### Arch-Stage Tool

**Arch-Stage** (originally HypoStage) was designed and implemented as an undergraduate capstone project by Pedro Henrique Mariano Corrêa, supervised by the author and co-supervised by Prof. Paulo Meirelles. The initial tool is a Backstage Internal Developer Portal plugin, developed up to commit [`ceee509`](https://github.com/ArchHypo/hypo-stage/commit/ceee509776508081ebdd473c2c4f710b8ef55947) in the [`hypo-stage`](https://github.com/ArchHypo/hypo-stage) repository. The [senior thesis](https://github.com/ArchHypo/hypo-stage-senior-thesis) documents its design.

This master's thesis builds on that artifact: commits after `ceee509` reflect refinements from empirical use with real teams. The master's contribution is the empirical evaluation and evidence-driven refinement, not the tool's original design.

## Repository Structure

```
.
├── thesis.pdf              # Compiled thesis (latest version)
├── thesis.tex              # Main LaTeX file (entry point)
├── references.bib          # Bibliography (BibLaTeX format)
├── chapters/               # Thesis content (author's writing)
│   ├── abstract.tex        #   Abstract (EN) and Resumo (PT)
│   ├── 01-introduction.tex #   Chapter 1: Introduction
│   ├── 02-background.tex   #   Chapter 2: Background
│   ├── 03-related-work.tex #   Chapter 3: Related Work
│   └── 04-research-design.tex  Chapter 4: Research Design
├── figures/                # Thesis figures (add .pdf, .png, .jpg here)
├── template/               # IME-USP LaTeX template internals (do not edit)
│   ├── *.sty               #   Style packages
│   ├── *.bst, *.bbx, ...   #   Bibliography styles
│   ├── logos/               #   Institutional logos
│   ├── texlogsieve          #   Log filter tool
│   └── latexmkrc            #   Template build settings
├── latexmkrc               # Build config (loads template/latexmkrc)
├── .github/workflows/      # GitHub Actions CI (auto-builds PDF on push)
├── LICENSE
└── README.md
```

## Building the PDF

### Prerequisites

You need a TeX Live installation with `latexmk` and `biber`. On **Debian/Ubuntu**:

```bash
sudo apt-get update
sudo apt-get install -y \
  biber \
  latexmk \
  texlive-plain-generic \
  texlive-latex-base \
  texlive-luatex \
  lmodern \
  fonts-lmodern \
  texlive-latex-recommended \
  texlive-fonts-recommended \
  texlive-latex-extra \
  texlive-fonts-extra \
  texlive-bibtex-extra \
  texlive-science \
  texlive-lang-english \
  texlive-lang-portuguese
```

On **macOS** with [MacTeX](https://www.tug.org/mactex/): install the full MacTeX distribution (all packages above are included).

On **Windows**: install [TeX Live](https://www.tug.org/texlive/) or [MiKTeX](https://miktex.org/) with the equivalent packages.

### Compile

From the repository root:

```bash
latexmk -pdf thesis.tex
```

This runs `pdflatex` + `biber` + `makeindex` as many times as needed and produces `thesis.pdf`.

To clean all build artifacts:

```bash
latexmk -C
```

### Continuous Integration

Every push to `main` triggers a [GitHub Actions workflow](.github/workflows/latex.yml) that compiles the thesis and uploads the resulting PDF as a downloadable artifact.

## License

The LaTeX template files are distributed under the [MIT License](LICENSE). The thesis content is by José Gonçalves Lima Neto, licensed under [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/).
