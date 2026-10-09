module

public import Mathlib

/-!
# The two-variable density statement for consecutive smooth integers

Both declarations below have no joint Dickman law as a hypothesis.
The second declaration includes the defining initial values and differential
equation of the Dickman function in the mathematical statement itself.
The analytic proof is due to OpenAI, result family 012. The Solution combines
that proof with the elementary change of threshold conventions.

The `sorry` terms occur only in this Comparator statement file.
-/

@[expose] public section

namespace Erdos928

open Filter
open scoped Topology

/-- Integers in the interval `[2,N]` satisfying a predicate. -/
noncomputable def counted (E : ℕ → Prop) (N : ℕ) : Finset ℕ := by
  classical
  exact (Finset.Icc 2 N).filter E

/-- The cardinality of that finite set. -/
noncomputable def count (E : ℕ → Prop) (N : ℕ) : ℕ := (counted E N).card

/-- Ordinary unweighted counting, normalized through real endpoints. -/
noncomputable def density (E : ℕ → Prop) (X : ℝ) : ℝ :=
  (count E ⌊X⌋₊ : ℝ) / X

/-- Natural-density existence in the exact strict, shifted formulation. -/
theorem erdos_928_density_exists (a b : ℝ) (ha : 0 < a) (ha1 : a < 1)
    (hb : 0 < b) (hb1 : b < 1) :
    ∃ L : ℝ, Tendsto (density (fun n =>
      (n.maxPrimeFac : ℝ) < (n : ℝ) ^ a ∧
      ((n + 1).maxPrimeFac : ℝ) < ((n + 1 : ℕ) : ℝ) ^ b))
      atTop (𝓝 L) := by
  sorry

/-- The density equals the Dickman product; its defining properties are
included to make the statement independent of an implementation-specific name. -/
theorem erdos_928_with_dickman_specification :
    ∃ ρ : ℝ → ℝ,
      Continuous ρ ∧
      (∀ u : ℝ, 0 ≤ u → u ≤ 1 → ρ u = 1) ∧
      (∀ u : ℝ, 1 < u → HasDerivAt ρ (-ρ (u - 1) / u) u) ∧
      ∀ a b : ℝ, 0 < a → a < 1 → 0 < b → b < 1 →
        Tendsto (density (fun n =>
          (n.maxPrimeFac : ℝ) < (n : ℝ) ^ a ∧
          ((n + 1).maxPrimeFac : ℝ) < ((n + 1 : ℕ) : ℝ) ^ b))
          atTop (𝓝 (ρ (1 / a) * ρ (1 / b))) := by
  sorry

end Erdos928
