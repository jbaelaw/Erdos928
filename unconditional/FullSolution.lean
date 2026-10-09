module

public import ConventionTransfer
public import OAI.NumberTheory.JointDickman.PaperMain

@[expose] public section

/-!
# Erdős Problem 928 from the proved joint Dickman law

The analytic theorem is OpenAI result family 012, Theorem 1.1, at the
pinned source revision recorded in vendor/source-manifest.json.
This file applies its Lean proof, rather than assuming its conclusion.
The elementary change of conventions is the earlier Erdos928 development.
-/

namespace Erdos928

open Filter
open scoped Topology

/-- Both developments use exactly the same real-endpoint counting function. -/
theorem density_eq_upstream (E : ℕ → Prop) :
    density E = OAI.JointDickman.realDensity E := by
  funext X
  rfl

/-- OpenAI's proved analytic result in the convention-transfer interface. -/
theorem jointDickmanLaw_proved :
    JointDickmanLaw OAI.Erdos970.NumberTheoryLean.Dickman.rho := by
  intro a b ha ha1 hb hb1
  rw [density_eq_upstream]
  exact OAI.JointDickmanPaper.joint_law a b ha ha1 hb hb1

/-- The exact two-variable product-density conclusion, with no joint-law hypothesis. -/
theorem problem928_proved :
    Problem928 OAI.Erdos970.NumberTheoryLean.Dickman.rho :=
  problem928_of_jointDickmanLaw _ jointDickmanLaw_proved

/-- The strict, shifted-threshold formulation through all real endpoints. -/
theorem erdos_928 (a b : ℝ) (ha : 0 < a) (ha1 : a < 1)
    (hb : 0 < b) (hb1 : b < 1) :
    Tendsto (density (fun n =>
      (n.maxPrimeFac : ℝ) < (n : ℝ) ^ a ∧
      ((n + 1).maxPrimeFac : ℝ) < ((n + 1 : ℕ) : ℝ) ^ b))
      atTop (𝓝 (OAI.Erdos970.NumberTheoryLean.Dickman.rho (1 / a) *
        OAI.Erdos970.NumberTheoryLean.Dickman.rho (1 / b))) :=
  problem928_proved a b ha ha1 hb hb1

/-- Natural-density existence as asked in the two-variable problem. -/
theorem erdos_928_density_exists (a b : ℝ) (ha : 0 < a) (ha1 : a < 1)
    (hb : 0 < b) (hb1 : b < 1) :
    ∃ L : ℝ, Tendsto (density (fun n =>
      (n.maxPrimeFac : ℝ) < (n : ℝ) ^ a ∧
      ((n + 1).maxPrimeFac : ℝ) < ((n + 1 : ℕ) : ℝ) ^ b))
      atTop (𝓝 L) :=
  ⟨_, erdos_928 a b ha ha1 hb hb1⟩


/-- A statement of the product law using only the defining properties of
Dickman's function, so its mathematical meaning does not depend on a name. -/
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
  refine ⟨OAI.Erdos970.NumberTheoryLean.Dickman.rho,
    OAI.Erdos970.NumberTheoryLean.Dickman.rho_continuous, ?_, ?_, ?_⟩
  · intro u _ hu
    exact OAI.Erdos970.NumberTheoryLean.Dickman.rho_initial hu
  · intro u hu
    exact OAI.Erdos970.NumberTheoryLean.Dickman.rho_hasDerivAt hu
  · exact erdos_928

end Erdos928
