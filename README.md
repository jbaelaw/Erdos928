# Erdős Problem 928 as a corollary of OpenAI's joint Dickman law

The original root project formalizes the implication in the
[one-page note](paper/erdos928_note.pdf). Its independent mathematical content
is an explicit counting bound and a transfer of ordinary natural density.
The root proof files use **Mathlib only** and are preserved unchanged.

The [full derivation](unconditional/README.md) adds OpenAI's actual Lean proof
as the analytic input. Its final theorems have no joint Dickman law as a
hypothesis. The source revisions, module-system port, and compatibility
repairs are recorded in that subproject. The analytic result is credited
to OpenAI result family 012.

To check the full density theorem, use the separate project:

```sh
cd unconditional
lake exe cache get
bash verify.sh
```

The revised manuscript is available in
[English](paper/versions/v2-2026-10-09/erdos928_note.pdf) and
[Korean](paper/versions/v2-2026-10-09/ko/erdos928_note_ko.pdf), with the corresponding
LaTeX sources and manuscript hash records beside the respective PDFs.
Both revised versions have four pages; the earlier paper is preserved.

## Original convention-transfer result

For a natural-valued function `P`, compare the counts, over integers `2 ≤ n ≤ X`,

- `A(X)`: `P(n) < n^a` and `P(n+1) < (n+1)^b`;
- `B(X)`: `P(n) ≤ n^a` and `P(n+1) ≤ n^b`.

For positive `a,b` and real `X ≥ 2`, we prove

```text
|A(X) - B(X)| ≤ floor(X^a) + floor((X+1)^b).
```

If `a,b < 1`, the normalized difference tends to zero. Thus any ordinary
natural-density limit for `B(X)/X` also holds for `A(X)/X`, with the same value.

Taking `P = Nat.maxPrimeFac` gives the exact strict, shifted-threshold
formulation of [Erdős Problem 928](https://www.erdosproblems.com/928) from the
joint Dickman law stated in **OpenAI result family 012, Theorem 1.1, page 2**:

> OpenAI, *The joint Dickman law for consecutive integers*, manuscript dated
> September 24, 2026,
> [pinned source](https://github.com/openai/math/blob/fd4aeeb2ee4fc729c18d98444fed42fd0529eeeb/preprints/The-joint-Dickman-law-for-consecutive-integers-September-24-2026/paper.pdf).

The final theorem in the root project is an **explicit implication**.
That project does not
re-prove OpenAI's analytic theorem, import its proof development, or claim an
independent new solution of the analytic problem. It also makes no assertion
about independence at three or more consecutive integers or about worldwide
priority of this identification. The contribution is the precise identification
with Problem 928 and the independently checked treatment of its conventions.

## Original project verification

The core counting and transfer proofs passed Lean 4.34.1. The complete release
build also passed Lean 4.35.0-rc3, with only `propext`, `Classical.choice`, and
`Quot.sound`; see [the axiom-check output](verification/lean-axioms.txt).
The native Comparator run with `--paranoid` also passed every bundled kernel;
see [the log](verification/comparator-paranoid.log) and
[source hashes](verification/comparator-paranoid.json).
The full Palomar mechanical preflight is recorded in
[GitHub Actions](https://github.com/jbaelaw/Erdos928/actions/workflows/palomar-preflight.yml).
Its report concerns the exact commit tested. A source build is not presented
as a completed Palomar registration.

## Reproduce the original project

Lean: `v4.35.0-rc3`.
Mathlib: `b84a70d6a5ed793cc46184160f4d4188d8c825fb`.

```sh
lake exe cache get
lake build
lake env lean Check.lean
lake comparator --config comparator.json --paranoid
```

The submitted claims are:

- `Erdos928.real_count_difference_bound`;
- `Erdos928.density_transfer`;
- `Erdos928.problem928_of_jointDickmanLaw`.

`Challenge.lean` is the auditable statement file and deliberately contains
Comparator placeholders. `Solution.lean` imports the complete proofs from
`Erdos928.lean`. The proof development contains no `sorry`, `admit`, additional
axiom, or `native_decide`. The permitted standard axioms are `propext`,
`Classical.choice`, and `Quot.sound`.

## Files

- [Paper](paper/erdos928_note.pdf) and [LaTeX source](paper/erdos928_note.tex).
- [Lean proofs](Erdos928.lean), [Challenge](Challenge.lean), and [Solution](Solution.lean).
- [Source and manuscript audit](paper/source_audit.txt).
- [Provenance and scope](formalization.yaml).

## Production and attribution

JI HO BAE directed the work. A Codex agent drafted the note and Lean code,
checked the cited source statements, and iterated against Lean diagnostics.
No independent human peer review is claimed. The earlier informal proof used
continuity and a squeeze argument; the final version uses the stronger finite
counting estimate and does not need continuity of the density-value function.

The analytic joint Dickman result is attributed to OpenAI. Bloom's problem page
supplies the exact target formulation. The root project contains the counting
and transfer development.
The separate `unconditional` project includes the upstream analytic proof
closure, with its provenance and compatibility changes recorded explicitly.

The original development and note are licensed under Apache-2.0.
Vendored components retain their upstream attribution and supplied licences.
