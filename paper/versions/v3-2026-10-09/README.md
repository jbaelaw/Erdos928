# English manuscript — version 3

**Erdős Problem 928: quantitative comparisons and original formulations**

**JI HO BAE — 9 October 2026 — 4 pages**

[PDF](erdos928_note.pdf) · [LaTeX source](erdos928_note.tex) · [Artifact hashes and verification scope](manifest.json)

This edition improves the comparison table while retaining the mathematical conclusions and proofs of version 2.

## Named formulations and precise citations

Table 1 now has five rows and three columns. It identifies each formulation by name and author, as well as by its reference and precise location:

1. OpenAI's joint Dickman law, Theorem 1.1, p. 2, as the reference theorem.
2. Problem 928 in Bloom's collection and Erdős's independence statement in the Manitoba paper.
3. Erdős's strict formulation in condition (1) of the Manitoba paper.
4. The two-integer case of Erdős's fixed-threshold formulation in the Debrecen paper.
5. The fixed-threshold upper-tail formulation of Erdős and Pomerance.

The table defines the count `N`, gives normalized limits throughout, states the exponent ranges and limiting variables, and connects each conclusion to its justification. The two strict moving-threshold forms explicitly cite Proposition 1 and Corollary 2 of this note. The fixed-threshold rows cite OpenAI's (11.7) and (11.8), including the equality and endpoint discussion. The Debrecen change of variables is linked to Section 3.2.

The surrounding prose distinguishes the reference theorem from the four source formulations. The English and Korean editions were checked for agreement of all mathematical expressions, citations and numbering. Only the English edition is included in this publication.

## Preservation and verification

The [version 2 manuscript](../v2-2026-10-09/README.md), the [original one-page paper](../../erdos928_note.pdf), and all existing Lean sources and verification artifacts are retained. The [separate Lean development branch](https://github.com/jbaelaw/Erdos928/tree/full-lean-928-20261009) is unaffected by this manuscript-only revision.

The shipped PDF and LaTeX source match the reviewed final files byte-for-byte. Both the desktop LaTeX compiler and the local PDF build succeeded; all four English pages were inspected. The final log has no undefined references, missing glyphs, or overfull/underfull box warnings.

To compile from this directory:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error erdos928_note.tex
```

The analytic joint Dickman law remains explicitly attributed to OpenAI. This revision makes no new formal-verification or priority claim. Preparation and review used Codex assistance under JI HO BAE's direction, consistently with the existing repository attribution.
