# English manuscript — version 2

**Erdős Problem 928: quantitative comparisons and original formulations**

**JI HO BAE — 9 October 2026 — 4 pages**

[Read the PDF](erdos928_note.pdf) · [LaTeX source](erdos928_note.tex) · [Artifact hashes and verification scope](manifest.json)

This revision makes explicit the deduction of the precise statement of Erdős Problem 928 from OpenAI's joint Dickman law. Its contribution is the finite comparison proof and the correspondence with the original formulations.

## Changes in this edition

- Proposition 1 bounds the symmetric difference of the two counting sets by `π(X^α) + π((X+1)^β)` and gives a second bound for the strict formulation with both thresholds based at `n`.
- Corollary 2 states the resulting density formula for both strict formulations, using OpenAI's Theorem 1.1 as the analytic input.
- Section 3 compares the Manitoba and Debrecen papers of Erdős with the 1978 Erdős–Pomerance paper, including fixed thresholds, upper tails, equality cases, and endpoints.
- The bibliography contains seven references checked at the cited passages. The classical marginal law is cited to the directly inspected de Bruijn paper; Schinzel's earlier infinitude result is acknowledged.
- The exposition identifies the mathematical contribution, distinguishes comparison errors from the analytic density evaluation, and makes the parameter ranges and limit conventions explicit.

## Relationship to the existing Lean release

The [original one-page PDF](../../erdos928_note.pdf) and [its source](../../erdos928_note.tex) remain at their established paths. All files present at baseline commit [`8cd4a3f82b22`](https://github.com/jbaelaw/Erdos928/commit/8cd4a3f82b22000c860560b6c090e4ac585e8f03) are preserved unchanged by this manuscript addition.

At that baseline, the Lean development proves the floor-based count-difference bound for a natural-valued function, the density-transfer theorem, and the explicit implication `JointDickmanLaw ρ → Problem928 ρ`. Its verification records continue to certify those statements. The prime-specific symmetric-difference bound and additional source comparisons in this edition have been checked as written mathematics; this manuscript addition does not extend the Lean certification scope.

The analytic joint Dickman law is attributed to OpenAI, *The joint Dickman law for consecutive integers*, 24 September 2026, [Theorem 1.1, p. 2, at the pinned commit](https://github.com/openai/math/blob/fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb/preprints/The-joint-Dickman-law-for-consecutive-integers-September-24-2026/paper.pdf). The fixed-threshold results used in Section 3 are (11.7)–(11.8), p. 80, of the same paper.

## Build and checks

Run from this directory with a TeX distribution containing the packages used in the source:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error erdos928_note.tex
```

The shipped PDF was generated with pdfLaTeX / TeX Live 2026 and visually inspected on all four pages. The final compilation has no undefined references, missing glyphs, or overfull/underfull box warnings. The PDF and source are byte-for-byte copies of the reviewed English final version; their SHA-256 hashes are in `manifest.json`.

Preparation and checking used Codex assistance under JI HO BAE's direction, consistently with the repository's existing attribution. No independent human peer review or independent re-verification of the complete upstream analytic proof is claimed.
