# Thesis project (canonical metadata)

## Identity

- **Student:** José Gonçalves Lima Neto
- **USP number:** 14743972
- **Program:** Ciência da Computação, IME-USP (Graduate Program in Computer Science)
- **Advisor:** Paulo Roberto Miranda Meirelles (Prof. Dr.)

## Titles (must match deposit; do not change after deposit)

**English (primary in this repo build):**

Hypo-Stage: Tool-Supported Architectural Hypothesis Engineering in Professional Software Development Teams --- A Case Study

**Portuguese (translated title):**

Hypo-Stage: Engenharia de Hipóteses Arquiteturais Apoiada por Ferramenta em Equipes Profissionais de Desenvolvimento de Software --- Um Estudo de Caso

## Theme (one paragraph)

This work studies **Hypo-Stage**, an open-source **Backstage** plugin developed under the **ArchHypo** research line (**ArchHypo** organization), in the context of **tool-supported architectural hypothesis engineering**. The empirical setting is professional software teams using an **Internal Developer Portal**. The thesis combines design-science and case-study elements: observations drive refinements to the tool and to usage guidance, with traceability to repository changes.

## Repository and PDF conventions

- Entry point: `thesis.tex`; chapters under `chapters/`.
- The IME-USP LaTeX template lives under `template/` (`imelooks`, `imegoodies`).
- Tracked build outputs: `thesis.pdf`, `presentation.pdf`, and a single date-stamped file under `archive/thesis-deposit-original-YYYYMMDD.pdf` aligned with the calendar date of the last source refresh (see `.cursor/skills/thesis-deposit-pdf-archive`).

## Current state

- **Defense completed** 11 June 2026. Committee feedback addressed on branch `fix/versao-corrigida-committee-feedback`.
- **Versão corrigida** built with `\tipotese{..., definitiva, ...}` and `\correctedversiontrue` (committee block on title page).
- **Deposit snapshots:** `archive/thesis-deposit-original-20260511.pdf` (pre-defense / deposited original — leave untouched on the versão-corrigida branch); `archive/thesis-deposit-corrected.pdf` (corrected version for Biblioteca Digital USP, aligned with current `thesis.pdf`).
- **Audit trail:** `docs/thesis-corrections/CHANGELOG-versao-corrigida.md` maps feedback IDs A1–A36, M1–M61, C1 → commits.
- **Remaining:** manual upload to Biblioteca Digital USP / Janus (deadline ≈ 10 Aug 2026; see `ime-workflow.md`).

## Deposit artifact names (reference)

- Pre-defense committee submission: **`thesis-deposit-original-20260503.pdf`** (3 May 2026; git history).
- Corrected-version refresh: **`thesis-deposit-corrected.pdf`** (aligned with current `thesis.pdf`; includes T28 initial-tool screenshot). Original deposit remains **`thesis-deposit-original-20260511.pdf`**.
