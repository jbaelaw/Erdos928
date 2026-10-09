# Complete Lean derivation of the two-variable density formula

This project connects OpenAI's proved joint Dickman law to the strict,
shifted-threshold formulation of Erdős Problem 928. The analytic result is
OpenAI result family 012, Theorem 1.1 of *The joint Dickman law for consecutive
integers*. The change of conventions is the earlier development in the root
of this repository.
Here `P(n) = Nat.maxPrimeFac n` is the largest prime divisor of `n`.
For fixed `0<a,b<1`, the asserted limit is

```text
#{2 ≤ n ≤ X : P(n) < n^a and P(n+1) < (n+1)^b} / X
  → rho(1/a) * rho(1/b), as real X → +∞.
```

The final declarations are:

- `Erdos928.erdos_928`: the limit is the product of the two Dickman values;
- `Erdos928.erdos_928_density_exists`: the natural density exists;
- `Erdos928.erdos_928_with_dickman_specification`: the product law together
  with continuity, initial values, and the differential equation defining
  the Dickman function.

These declarations have no joint-density hypothesis. The exponent conditions
remain `0 < a`, `a < 1`, `0 < b`, and `b < 1`. Counting is ordinary and
unweighted, through all real endpoints. The higher-order generalization to
three or more consecutive integers is outside these statements.

`FullChallenge.lean` is a small statement file importing only Mathlib.
`FullSolution.lean` supplies its proofs. The `sorry` placeholders in the
Challenge are intentional; they are not used by the Solution.

## Verification

The full build and axiom audit passed. Comparator with `--paranoid` accepted
both recorded declarations. The successful checks include NanoDa, Lean
paranoid, lean4lean, con-leche, con-ron, and Lean's default kernel.
The final claims use only `propext`, `Classical.choice`, and `Quot.sound`.

[Verification report](verification/report.json) · [Axiom and theorem-type output](verification/axioms.txt) · [Complete Comparator log](verification/comparator.txt)

## Sources and the module-system port

The vendored sources are the import closure needed by OpenAI's
`OAI.NumberTheory.JointDickman.PaperMain`, including the required parts of
PrimeNumberTheoremAnd, StrongPNT, and LeanArchitect. The exact repository
revisions, OpenAI's two official dependency patches, and per-file hashes are
recorded in `vendor/source-manifest.json`.

The source release uses Lean 4.34.1. This project uses Lean 4.35.0-rc3 and
Mathlib commit `b84a70d6a5ed793cc46184160f4d4188d8c825fb`. The initial port adds
module headers, makes legacy imports public, and exposes the declarations
that were public in the legacy module system. Any subsequent compatibility
repairs are recorded separately. Supplied upstream licence files are retained
under `vendor/licenses`; attribution remains with the respective upstream
projects.

This is an integration and formal derivation from OpenAI's analytic proof.
It does not claim a new analytic solution or priority for identifying the
connection with Problem 928.

## Reproduce

Run in this directory with the pinned toolchain and committed manifest:

```sh
lake exe cache get
bash verify.sh
```

The script builds the proof, checks the axiom dependencies of every final
declaration, and runs Comparator with all bundled kernels. Verification
evidence is recorded under `verification/`; a successful local check does
not by itself constitute Palomar registration.

The earlier root project and its original verification records are preserved.
