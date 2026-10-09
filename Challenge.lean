module

public import Mathlib

/-!
# The joint Dickman law implies the exact formulation of Erdős Problem 928

The independently proved contribution is a finite counting bound and a
transfer of ordinary natural density between weak same-base thresholds and
strict shifted thresholds. The last theorem is an implication: it does not
prove the analytic joint Dickman law. For the Dickman function, OpenAI's
result family 012, Theorem 1.1, supplies its explicit hypothesis.

Only this statement file contains intentional Comparator placeholders.
-/

@[expose] public section

namespace Erdos928

open Filter
open scoped Topology

/-- The integers n in [2,N] satisfying E. -/
noncomputable def counted (E : ℕ → Prop) (N : ℕ) : Finset ℕ := by
  classical
  exact (Finset.Icc 2 N).filter E

/-- The number of integers in [2,N] satisfying E. -/
noncomputable def count (E : ℕ → Prop) (N : ℕ) : ℕ := (counted E N).card

/-- Ordinary, unweighted density through real endpoints. -/
noncomputable def density (E : ℕ → Prop) (X : ℝ) : ℝ :=
  (count E ⌊X⌋₊ : ℝ) / X

/-- Both weak upper bounds use the base n. -/
def weakEvent (P : ℕ → ℕ) (a b : ℝ) (n : ℕ) : Prop :=
  (P n : ℝ) ≤ (n : ℝ) ^ a ∧ (P (n + 1) : ℝ) ≤ (n : ℝ) ^ b

/-- Strict upper bounds use the respective bases n and n+1. -/
def strictEvent (P : ℕ → ℕ) (a b : ℝ) (n : ℕ) : Prop :=
  (P n : ℝ) < (n : ℝ) ^ a ∧ (P (n + 1) : ℝ) < ((n + 1 : ℕ) : ℝ) ^ b

/-- The analytic joint-density premise, with its value function explicit. -/
def JointDickmanLaw (ρ : ℝ → ℝ) : Prop :=
  ∀ a b : ℝ, 0 < a → a < 1 → 0 < b → b < 1 →
    Tendsto (density (weakEvent Nat.maxPrimeFac a b)) atTop
      (𝓝 (ρ (1 / a) * ρ (1 / b)))

/-- The two-variable density assertion, in the exact conventions of Problem 928. -/
def Problem928 (ρ : ℝ → ℝ) : Prop :=
  ∀ a b : ℝ, 0 < a → a < 1 → 0 < b → b < 1 →
    Tendsto (density (strictEvent Nat.maxPrimeFac a b)) atTop
      (𝓝 (ρ (1 / a) * ρ (1 / b)))

/-- The manuscript's finite bound, valid for any natural-valued function P. -/
theorem real_count_difference_bound (P : ℕ → ℕ) (a b X : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hX : 2 ≤ X) :
    |(count (strictEvent P a b) ⌊X⌋₊ : ℝ) -
      (count (weakEvent P a b) ⌊X⌋₊ : ℝ)| ≤
      (⌊X ^ a⌋₊ : ℝ) + (⌊(X + 1) ^ b⌋₊ : ℝ) := by
  sorry

/-- At each fixed pair of subunit positive exponents, any existing density
value transfers unchanged. No continuity of a density-value function is needed. -/
theorem density_transfer (P : ℕ → ℕ) (a b L : ℝ)
    (ha : 0 < a) (ha1 : a < 1) (hb : 0 < b) (hb1 : b < 1)
    (h : Tendsto (density (weakEvent P a b)) atTop (𝓝 L)) :
    Tendsto (density (strictEvent P a b)) atTop (𝓝 L) := by
  sorry

/-- The exact logical consequence recorded in the note; the analytic joint
law is an explicit hypothesis, not a new axiom or a conclusion proved here. -/
theorem problem928_of_jointDickmanLaw (ρ : ℝ → ℝ)
    (h : JointDickmanLaw ρ) : Problem928 ρ := by
  sorry

end Erdos928
