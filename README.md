# Evaluating and Refining Hypo-Stage: Supporting Architectural Hypotheses in Software Engineering Teams

Master's thesis in Computer Science at **IME-USP** (Institute of Mathematics and Statistics, University of São Paulo).

| | |
|---|---|
| **Author** | José Gonçalves Lima Neto |
| **Advisor** | Prof. Dr. Paulo Roberto Miranda Meirelles |
| **Program** | Graduate Program in Computer Science — IME-USP |
| **Year** | 2026 |

## Read the Documents

| Document | Description |
|---|---|
| **[thesis.pdf](thesis.pdf)** | Full thesis (latest compiled version) |
| **[presentation.pdf](presentation.pdf)** | Defense presentation slides (Beamer/IME theme) |

## About

This thesis empirically evaluates and refines **[Hypo-Stage](https://github.com/ArchHypo/hypo-stage)**, a support tool for the **ArchHypo** technique, by applying it with multiple software engineering teams working on a scaled software product in a real-world organization. The research assesses how Hypo-Stage supports managing architectural uncertainty and uses the findings to inform the tool's improvement.

## Template

This repository is based on the [IME-USP LaTeX template](https://github.com/ccsl-usp/modelo-latex) (`ccsl-usp/modelo-latex`) by Jesús P. Mena-Chalco, Fabio Kon, Paulo Feofiloff, and Nelson Lago.

## Context and Lineage

### Qualification Work

The author's qualification research (December 2024) explored centralization vs. decentralization of software architecture decision-making through a systematic mapping study and a multivocal literature review. The committee recommended narrowing the scope to specific teams and a concrete artifact.

### ArchHypo

The **ArchHypo** technique (Silva et al., [IEEE Software 2024](https://doi.org/10.1109/MS.2024.3383628), [TSE 2025](https://doi.org/10.1109/TSE.2024.3520477)) uses hypotheses engineering to manage software architecture uncertainty. Prior evaluations demonstrated its value but highlighted significant adoption barriers — particularly the learning curve and cognitive load of manual application.

### Hypo-Stage Tool

**Hypo-Stage** was designed and implemented as an undergraduate capstone project by Pedro Henrique Mariano Corrêa, supervised by the author and co-supervised by Prof. Paulo Meirelles. The initial tool is a Backstage Internal Developer Portal plugin, developed up to commit [`ceee509`](https://github.com/ArchHypo/hypo-stage/commit/ceee509776508081ebdd473c2c4f710b8ef55947) in the [`hypo-stage`](https://github.com/ArchHypo/hypo-stage) repository. The [senior thesis](https://github.com/ArchHypo/hypo-stage-senior-thesis) documents its design.

This master's thesis builds on that artifact: commits after `ceee509` reflect refinements from empirical use with real teams. The master's contribution is the empirical evaluation and evidence-driven refinement, not the tool's original design.

## Repository Structure

```
.
├── thesis.pdf                  # Compiled thesis (latest version)
├── thesis.tex                  # Thesis entry point
├── presentation.pdf            # Compiled presentation slides
├── presentation.tex            # Presentation entry point (Beamer)
├── references.bib              # Shared bibliography (BibLaTeX format)
├── chapters/                   # Thesis content (author's writing)
│   ├── abstract.tex            #   Abstract (EN) and Resumo (PT)
│   ├── 01-introduction.tex     #   Chapter 1: Introduction
│   ├── 02-background.tex       #   Chapter 2: Background
│   ├── 03-related-work.tex     #   Chapter 3: Related Work
│   ├── 04-research-design.tex  #   Chapter 4: Research Design
│   ├── 05-results.tex          #   Chapter 5: Results and Refinements (merged)
│   ├── 06-discussion.tex       #   Optional scaffold (omitted from thesis.tex)
│   ├── 07-conclusion.tex       #   Chapter 6 in PDF: Conclusion
│   └── appendix-a-instruments.tex  Appendix A: Research Instruments
├── figures/                    # Thesis figures (.pdf, .png, .jpg)
├── template/                   # IME-USP LaTeX template internals (do not edit)
│   ├── *.sty                   #   Style packages (imegoodies, imelooks, etc.)
│   ├── *.bst, *.bbx, ...      #   Bibliography styles (thesis + beamer)
│   ├── logos/                  #   Institutional logos (IME, USP, CC-BY)
│   ├── texlogsieve             #   Log filter tool
│   └── latexmkrc               #   Template build settings
├── latexmkrc                   # Build config (loads template/latexmkrc)
├── .github/workflows/          # GitHub Actions CI (builds both PDFs on push)
├── LICENSE
└── README.md
```

## Building the PDFs

### Prerequisites

You need a TeX Live installation with `latexmk` and `biber`.

#### macOS

**Option A: Full MacTeX (recommended, ~4 GB)**

This is the easiest option. It installs everything you need in one step, including `latexmk`, `biber`, all fonts, and the TeXShop editor.

```bash
# Install via Homebrew
brew install --cask mactex

# IMPORTANT: restart your terminal after installation, or run:
eval "$(/usr/libexec/path_helper)"

# Verify installation
latexmk --version
biber --version
```

Alternatively, download the installer directly from [tug.org/mactex](https://www.tug.org/mactex/).

**Option B: BasicTeX (lightweight, ~100 MB) + manual packages**

If you prefer a minimal install, use BasicTeX and add the required packages manually:

```bash
# Install BasicTeX
brew install --cask basictex

# Restart your terminal, then install required tools and packages
eval "$(/usr/libexec/path_helper)"
sudo tlmgr update --self
sudo tlmgr install \
  latexmk biber \
  collection-fontsrecommended \
  collection-langenglish \
  collection-langportuguese \
  biblatex biblatex-abnt \
  booktabs caption csquotes enumitem etoolbox fancyhdr float \
  footmisc framed geometry hyperref indentfirst microtype \
  parskip pgfplots setspace subcaption tcolorbox titlesec \
  todonotes xcolor xpatch siunitx adjustbox makecell \
  threeparttable colortbl multirow longtable pdfpages \
  appendix datetime2 contour pgfgantt beamer \
  beamertheme-metropolis libertinus sourcecodepro
```

If you hit a missing `.sty` file during compilation, find and install it with:

```bash
tlmgr search --global --file missing-file.sty
sudo tlmgr install package-name
```

**Recommended editor setup:** [VS Code](https://code.visualstudio.com/) with the [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) extension works well on macOS. After installing MacTeX or BasicTeX, the extension automatically detects `latexmk` and provides build-on-save, PDF preview, and SyncTeX (click PDF to jump to source).

#### Debian / Ubuntu

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

#### Windows

Install [TeX Live](https://www.tug.org/texlive/) (full scheme) or [MiKTeX](https://miktex.org/) with the equivalent packages. Both include `latexmk` and `biber`.

### Compile

From the repository root:

```bash
# Build the thesis
latexmk -pdf thesis.tex

# Build the presentation
latexmk -pdf presentation.tex

# Clean all build artifacts
latexmk -C
```

### Continuous Integration

Every push to `main` triggers a [GitHub Actions workflow](.github/workflows/latex.yml) that compiles both the thesis and the presentation, uploading each as a downloadable artifact.

## License

The LaTeX template files are distributed under the [MIT License](LICENSE). The thesis content is by José Gonçalves Lima Neto, licensed under [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/).
