# English manuscript — version 5

**Erdős Problem 928: quantitative comparisons and original formulations**

**JI HO BAE — 9 October 2026 — 4 pages**

[PDF](erdos928_note.pdf) · [LaTeX source](erdos928_note.tex) · [Artifact hashes and verification scope](manifest.json)

This edition focuses on natural, precise English exposition. Four parallel editorial reviews were integrated and rechecked throughout the manuscript. All displayed and inline mathematics, the complete comparison table and the bibliography are preserved from version 4.

The abstract separates the comparison of sets from the bound on the size of their symmetric difference. The introduction states the two required changes directly: making the inequalities strict and basing the second threshold on the second integer. The proof makes the prime injections and their counting consequences explicit. The original-source discussions use direct descriptions of the inequalities and the limits they imply. The upper-tail argument also states the zero–zero boundary case expressly.

OpenAI supplies the analytic joint Dickman law. This note supplies the elementary finite comparison bounds and explains how the cited results give the limits in the original formulations. Attribution and the scope of the contribution are unchanged.

The companion Korean edition was aligned with the explanatory changes. Mathematics, citation keys, numbering and external URLs agree in both languages. Both PDFs compile without warnings, and all eight pages were inspected. Only the English edition is published here.

[Version 4](../v4-2026-10-09/README.md), [version 3](../v3-2026-10-09/README.md), [version 2](../v2-2026-10-09/README.md), the [original one-page manuscript](../../erdos928_note.pdf), and all existing Lean sources and verification records are preserved. The [separate Lean development branch](https://github.com/jbaelaw/Erdos928/tree/full-lean-928-20261009) is unaffected. This editorial revision makes no new priority or formal-verification claim.

To compile:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error erdos928_note.tex
```

Preparation and review used Codex assistance under JI HO BAE's direction, consistently with the repository's existing attribution.
