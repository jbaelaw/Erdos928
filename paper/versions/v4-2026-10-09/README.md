# English manuscript — version 4

**Erdős Problem 928: quantitative comparisons and original formulations**

**JI HO BAE — 9 October 2026 — 4 pages**

[PDF](erdos928_note.pdf) · [LaTeX source](erdos928_note.tex) · [Artifact hashes and verification scope](manifest.json)

This edition improves the prose and mathematical exposition throughout the note. It preserves the displayed mathematics, conclusions, bibliography and named five-row comparison table of version 3.

The abstract states the density deduction and the finite comparison estimates directly. The introduction and source discussions identify the Manitoba, Debrecen and Erdős–Pomerance papers by name alongside precise citations. The proof explains the failed conditions before the prime injections, and the source deductions make the normalization of the endpoint discrepancy and the zero-exponent upper-tail case explicit. Terminology and attribution are consistent throughout.

OpenAI supplies the analytic joint Dickman law. This note supplies elementary finite comparison estimates that transfer it to the exact inequalities in Problem 928, together with the correspondence among related source formulations. The comparison bounds control the change of conventions; they do not supply a convergence rate for the analytic law.

Four parallel reviews covered English prose, mathematical exposition, Korean prose and source coherence. Their proposals were integrated and rechecked by the coordinating reviewer. All displayed and inline mathematical expressions, citation keys, numbering and external URLs agree between the English and companion Korean editions. Both editions compiled without warnings and all eight pages were inspected. Only the English edition is published here.

The [version 3 manuscript](../v3-2026-10-09/README.md), [version 2 manuscript](../v2-2026-10-09/README.md), [original one-page paper](../../erdos928_note.pdf), and all existing Lean sources and verification records are preserved. The [separate Lean development branch](https://github.com/jbaelaw/Erdos928/tree/full-lean-928-20261009) is unaffected. This manuscript revision makes no new priority or formal-verification claim.

To compile:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error erdos928_note.tex
```

Preparation and review used Codex assistance under JI HO BAE's direction, consistently with the existing repository attribution. The PDF and source match the reviewed artifacts byte-for-byte.
