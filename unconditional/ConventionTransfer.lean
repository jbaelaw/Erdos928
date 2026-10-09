module

public import Mathlib

/-!
The change of conventions in Erdős Problem 928.

This file proves an elementary counting estimate for any natural-valued
function P. It does not assume the joint Dickman law and does not define
the Dickman function. The final transfer theorem takes a density limit
as a hypothesis. FullSolution.lean supplies that hypothesis from OpenAI.
-/

@[expose] public section

namespace Erdos928

open Filter
open scoped Topology

noncomputable def counted (E : ℕ → Prop) (N : ℕ) : Finset ℕ := by
  classical
  exact (Finset.Icc 2 N).filter E

noncomputable def count (E : ℕ → Prop) (N : ℕ) : ℕ := (counted E N).card

noncomputable def density (E : ℕ → Prop) (X : ℝ) : ℝ :=
  (count E ⌊X⌋₊ : ℝ) / X

def weakEvent (P : ℕ → ℕ) (a b : ℝ) (n : ℕ) : Prop :=
  (P n : ℝ) ≤ (n : ℝ) ^ a ∧ (P (n + 1) : ℝ) ≤ (n : ℝ) ^ b

def strictEvent (P : ℕ → ℕ) (a b : ℝ) (n : ℕ) : Prop :=
  (P n : ℝ) < (n : ℝ) ^ a ∧ (P (n + 1) : ℝ) < ((n + 1 : ℕ) : ℝ) ^ b

def equalityEvent (P : ℕ → ℕ) (a : ℝ) (n : ℕ) : Prop :=
  (P n : ℝ) = (n : ℝ) ^ a

def stripEvent (P : ℕ → ℕ) (b : ℝ) (n : ℕ) : Prop :=
  (n : ℝ) ^ b < (P (n + 1) : ℝ) ∧
    (P (n + 1) : ℝ) < ((n + 1 : ℕ) : ℝ) ^ b

@[simp] theorem mem_counted {E : ℕ → Prop} {N n : ℕ} :
    n ∈ counted E N ↔ 2 ≤ n ∧ n ≤ N ∧ E n := by
  classical
  simp [counted, and_assoc]

theorem equality_count_le (P : ℕ → ℕ) (a : ℝ) (ha : 0 < a) (N : ℕ) :
    count (equalityEvent P a) N ≤ ⌊(N : ℝ) ^ a⌋₊ := by
  classical
  have hmap : Set.MapsTo P (↑(counted (equalityEvent P a) N) : Set ℕ)
      (↑(Finset.Icc 1 ⌊(N : ℝ) ^ a⌋₊) : Set ℕ) := by
    intro n hn
    obtain ⟨hn2, hnN, heq⟩ := mem_counted.mp hn
    change (P n : ℝ) = (n : ℝ) ^ a at heq
    apply Finset.mem_Icc.mpr
    constructor
    · have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
      have hp0 : (0 : ℝ) < P n := by rw [heq]; exact Real.rpow_pos_of_pos hn0 a
      exact Nat.succ_le_of_lt (by exact_mod_cast hp0)
    · apply Nat.le_floor
      rw [heq]
      exact Real.rpow_le_rpow (Nat.cast_nonneg n) (by exact_mod_cast hnN) ha.le
  have hinj : Set.InjOn P (↑(counted (equalityEvent P a) N) : Set ℕ) := by
    intro n hn m hm hnm
    have hnE := (mem_counted.mp hn).2.2
    have hmE := (mem_counted.mp hm).2.2
    change (P n : ℝ) = (n : ℝ) ^ a at hnE
    change (P m : ℝ) = (m : ℝ) ^ a at hmE
    have hp : (n : ℝ) ^ a = (m : ℝ) ^ a :=
      hnE.symm.trans ((congrArg (fun v : ℕ => (v : ℝ)) hnm).trans hmE)
    have hle : (n : ℝ) ≤ (m : ℝ) :=
      (Real.rpow_le_rpow_iff (Nat.cast_nonneg n) (Nat.cast_nonneg m) ha).mp hp.le
    have hge : (m : ℝ) ≤ (n : ℝ) :=
      (Real.rpow_le_rpow_iff (Nat.cast_nonneg m) (Nat.cast_nonneg n) ha).mp hp.ge
    have hreal : (n : ℝ) = (m : ℝ) := le_antisymm hle hge
    exact_mod_cast hreal
  simpa [count] using Finset.card_le_card_of_injOn P hmap hinj

theorem strip_count_le (P : ℕ → ℕ) (b : ℝ) (hb : 0 < b) (N : ℕ) :
    count (stripEvent P b) N ≤ ⌊((N + 1 : ℕ) : ℝ) ^ b⌋₊ := by
  classical
  have hmap : Set.MapsTo (fun n => P (n + 1))
      (↑(counted (stripEvent P b) N) : Set ℕ)
      (↑(Finset.Icc 1 ⌊((N + 1 : ℕ) : ℝ) ^ b⌋₊) : Set ℕ) := by
    intro n hn
    obtain ⟨hn2, hnN, hlow, hupp⟩ := mem_counted.mp hn
    apply Finset.mem_Icc.mpr
    constructor
    · have hp0 : (0 : ℝ) < P (n + 1) :=
        lt_of_le_of_lt (Real.rpow_nonneg (Nat.cast_nonneg n) b) hlow
      exact Nat.succ_le_of_lt (by exact_mod_cast hp0)
    · apply Nat.le_floor
      exact hupp.le.trans (Real.rpow_le_rpow (Nat.cast_nonneg (n + 1))
        (by exact_mod_cast Nat.add_le_add_right hnN 1) hb.le)
  have hinj : Set.InjOn (fun n => P (n + 1))
      (↑(counted (stripEvent P b) N) : Set ℕ) := by
    intro n hn m hm hnm
    obtain ⟨_, _, hnlo, hnhi⟩ := mem_counted.mp hn
    obtain ⟨_, _, hmlo, hmhi⟩ := mem_counted.mp hm
    have hval : (P (n + 1) : ℝ) = P (m + 1) := by exact_mod_cast hnm
    rcases lt_trichotomy n m with hlt | heq | hgt
    · have hpow := Real.rpow_le_rpow (Nat.cast_nonneg (n + 1))
        (show ((n + 1 : ℕ) : ℝ) ≤ m by exact_mod_cast (show n + 1 ≤ m by omega)) hb.le
      linarith
    · exact heq
    · have hpow := Real.rpow_le_rpow (Nat.cast_nonneg (m + 1))
        (show ((m + 1 : ℕ) : ℝ) ≤ n by exact_mod_cast (show m + 1 ≤ n by omega)) hb.le
      linarith
  simpa [count] using Finset.card_le_card_of_injOn (fun n => P (n + 1)) hmap hinj

/-- A finite, explicit bound for the difference between the two conventions. -/
theorem count_difference_bound (P : ℕ → ℕ) (a b : ℝ)
    (ha : 0 < a) (hb : 0 < b) (N : ℕ) :
    |(count (strictEvent P a b) N : ℝ) - (count (weakEvent P a b) N : ℝ)| ≤
      (⌊(N : ℝ) ^ a⌋₊ : ℝ) + (⌊((N + 1 : ℕ) : ℝ) ^ b⌋₊ : ℝ) := by
  classical
  have hBA : counted (weakEvent P a b) N ⊆
      counted (strictEvent P a b) N ∪ counted (equalityEvent P a) N := by
    intro n hn
    obtain ⟨hn2, hnN, haN, hbN⟩ := mem_counted.mp hn
    by_cases hlt : (P n : ℝ) < (n : ℝ) ^ a
    · apply Finset.mem_union.mpr
      left
      apply mem_counted.mpr
      refine ⟨hn2, hnN, hlt, hbN.trans_lt ?_⟩
      exact Real.rpow_lt_rpow (Nat.cast_nonneg n)
        (by exact_mod_cast Nat.lt_succ_self n) hb
    · apply Finset.mem_union.mpr
      right
      exact mem_counted.mpr ⟨hn2, hnN, le_antisymm haN (le_of_not_gt hlt)⟩
  have hAB : counted (strictEvent P a b) N ⊆
      counted (weakEvent P a b) N ∪ counted (stripEvent P b) N := by
    intro n hn
    obtain ⟨hn2, hnN, haN, hbN⟩ := mem_counted.mp hn
    by_cases hle : (P (n + 1) : ℝ) ≤ (n : ℝ) ^ b
    · exact Finset.mem_union.mpr (Or.inl (mem_counted.mpr ⟨hn2, hnN, haN.le, hle⟩))
    · exact Finset.mem_union.mpr (Or.inr
        (mem_counted.mpr ⟨hn2, hnN, lt_of_not_ge hle, hbN⟩))
  have hcA : count (strictEvent P a b) N ≤
      count (weakEvent P a b) N + ⌊((N + 1 : ℕ) : ℝ) ^ b⌋₊ :=
    (Finset.card_le_card hAB).trans
      ((Finset.card_union_le _ _).trans (Nat.add_le_add_left (strip_count_le P b hb N) _))
  have hcB : count (weakEvent P a b) N ≤
      count (strictEvent P a b) N + ⌊(N : ℝ) ^ a⌋₊ :=
    (Finset.card_le_card hBA).trans
      ((Finset.card_union_le _ _).trans (Nat.add_le_add_left (equality_count_le P a ha N) _))
  have hcAr : (count (strictEvent P a b) N : ℝ) ≤
      (count (weakEvent P a b) N : ℝ) + (⌊((N + 1 : ℕ) : ℝ) ^ b⌋₊ : ℝ) := by
    exact_mod_cast hcA
  have hcBr : (count (weakEvent P a b) N : ℝ) ≤
      (count (strictEvent P a b) N : ℝ) + (⌊(N : ℝ) ^ a⌋₊ : ℝ) := by
    exact_mod_cast hcB
  have he0 : (0 : ℝ) ≤ ⌊(N : ℝ) ^ a⌋₊ := Nat.cast_nonneg _
  have hf0 : (0 : ℝ) ≤ ⌊((N + 1 : ℕ) : ℝ) ^ b⌋₊ := Nat.cast_nonneg _
  rw [abs_le]
  constructor <;> linarith

theorem density_difference_bound (P : ℕ → ℕ) (a b : ℝ)
    (ha : 0 < a) (hb : 0 < b) {X : ℝ} (hX : 1 ≤ X) :
    |density (strictEvent P a b) X - density (weakEvent P a b) X| ≤
      X ^ (a - 1) + 2 ^ b * X ^ (b - 1) := by
  have hX0 : 0 < X := lt_of_lt_of_le zero_lt_one hX
  have hfloor : (⌊X⌋₊ : ℝ) ≤ X := Nat.floor_le hX0.le
  have hA : (⌊(⌊X⌋₊ : ℝ) ^ a⌋₊ : ℝ) ≤ X ^ a :=
    (Nat.floor_le (Real.rpow_nonneg (Nat.cast_nonneg _) a)).trans
      (Real.rpow_le_rpow (Nat.cast_nonneg _) hfloor ha.le)
  have hB : (⌊((⌊X⌋₊ + 1 : ℕ) : ℝ) ^ b⌋₊ : ℝ) ≤ (2 * X) ^ b := by
    apply (Nat.floor_le (Real.rpow_nonneg (Nat.cast_nonneg _) b)).trans
    apply Real.rpow_le_rpow (Nat.cast_nonneg _) _ hb.le
    push_cast
    linarith
  unfold density
  rw [← sub_div, abs_div, abs_of_pos hX0]
  calc
    _ ≤ ((⌊(⌊X⌋₊ : ℝ) ^ a⌋₊ : ℝ) +
        (⌊((⌊X⌋₊ + 1 : ℕ) : ℝ) ^ b⌋₊ : ℝ)) / X :=
      div_le_div_of_nonneg_right (count_difference_bound P a b ha hb ⌊X⌋₊) hX0.le
    _ ≤ (X ^ a + (2 * X) ^ b) / X :=
      div_le_div_of_nonneg_right (add_le_add hA hB) hX0.le
    _ = X ^ (a - 1) + 2 ^ b * X ^ (b - 1) := by
      rw [Real.mul_rpow (by norm_num : (0 : ℝ) ≤ 2) hX0.le,
        Real.rpow_sub_one hX0.ne' a, Real.rpow_sub_one hX0.ne' b]
      ring

/-- The exact real-endpoint counting estimate printed in the note. -/
theorem real_count_difference_bound (P : ℕ → ℕ) (a b X : ℝ)
    (ha : 0 < a) (hb : 0 < b) (hX : 2 ≤ X) :
    |(count (strictEvent P a b) ⌊X⌋₊ : ℝ) -
      (count (weakEvent P a b) ⌊X⌋₊ : ℝ)| ≤
      (⌊X ^ a⌋₊ : ℝ) + (⌊(X + 1) ^ b⌋₊ : ℝ) := by
  have hfloor : (⌊X⌋₊ : ℝ) ≤ X := Nat.floor_le (by linarith)
  have haFloor : ⌊(⌊X⌋₊ : ℝ) ^ a⌋₊ ≤ ⌊X ^ a⌋₊ :=
    Nat.floor_mono (Real.rpow_le_rpow (Nat.cast_nonneg _) hfloor ha.le)
  have hbFloor : ⌊((⌊X⌋₊ + 1 : ℕ) : ℝ) ^ b⌋₊ ≤ ⌊(X + 1) ^ b⌋₊ := by
    apply Nat.floor_mono
    apply Real.rpow_le_rpow (Nat.cast_nonneg _) _ hb.le
    push_cast
    linarith
  apply (count_difference_bound P a b ha hb ⌊X⌋₊).trans
  exact add_le_add (by exact_mod_cast haFloor) (by exact_mod_cast hbFloor)

theorem density_difference_tendsto_zero (P : ℕ → ℕ) (a b : ℝ)
    (ha : 0 < a) (ha1 : a < 1) (hb : 0 < b) (hb1 : b < 1) :
    Tendsto (fun X : ℝ =>
      density (strictEvent P a b) X - density (weakEvent P a b) X)
      atTop (𝓝 0) := by
  have hpa : Tendsto (fun X : ℝ => X ^ (a - 1)) atTop (𝓝 0) := by
    simpa only [neg_sub] using (tendsto_rpow_neg_atTop (sub_pos.mpr ha1))
  have hpb : Tendsto (fun X : ℝ => X ^ (b - 1)) atTop (𝓝 0) := by
    simpa only [neg_sub] using (tendsto_rpow_neg_atTop (sub_pos.mpr hb1))
  have hbound : Tendsto (fun X : ℝ => X ^ (a - 1) + 2 ^ b * X ^ (b - 1))
      atTop (𝓝 0) := by
    simpa using hpa.add (tendsto_const_nhds.mul hpb)
  have habs : Tendsto (fun X : ℝ =>
      |density (strictEvent P a b) X - density (weakEvent P a b) X|)
      atTop (𝓝 0) :=
    squeeze_zero' (Eventually.of_forall fun X => abs_nonneg _)
      ((eventually_ge_atTop (1 : ℝ)).mono fun X hX =>
        density_difference_bound P a b ha hb hX) hbound
  exact (tendsto_iff_norm_sub_tendsto_zero).2 (by simpa [Real.norm_eq_abs] using habs)

/-- Transfer the exact density value; no continuity of that value is required. -/
theorem density_transfer (P : ℕ → ℕ) (a b L : ℝ)
    (ha : 0 < a) (ha1 : a < 1) (hb : 0 < b) (hb1 : b < 1)
    (h : Tendsto (density (weakEvent P a b)) atTop (𝓝 L)) :
    Tendsto (density (strictEvent P a b)) atTop (𝓝 L) := by
  have hsum := (density_difference_tendsto_zero P a b ha ha1 hb hb1).add h
  simpa only [sub_add_cancel, zero_add] using hsum

/-- The analytic input, with its density-value function kept explicit. -/
def JointDickmanLaw (ρ : ℝ → ℝ) : Prop :=
  ∀ a b : ℝ, 0 < a → a < 1 → 0 < b → b < 1 →
    Tendsto (density (weakEvent Nat.maxPrimeFac a b)) atTop
      (𝓝 (ρ (1 / a) * ρ (1 / b)))

/-- The exact two-variable density assertion in Erdős Problem 928. -/
def Problem928 (ρ : ℝ → ℝ) : Prop :=
  ∀ a b : ℝ, 0 < a → a < 1 → 0 < b → b < 1 →
    Tendsto (density (strictEvent Nat.maxPrimeFac a b)) atTop
      (𝓝 (ρ (1 / a) * ρ (1 / b)))

/-- The note's logical claim. No theorem about the analytic input is assumed
as an axiom: that input is an explicit hypothesis of the implication. -/
theorem problem928_of_jointDickmanLaw (ρ : ℝ → ℝ)
    (h : JointDickmanLaw ρ) : Problem928 ρ := by
  intro a b ha ha1 hb hb1
  exact density_transfer Nat.maxPrimeFac a b (ρ (1 / a) * ρ (1 / b))
    ha ha1 hb hb1 (h a b ha ha1 hb hb1)

end Erdos928

#print axioms Erdos928.count_difference_bound
#print axioms Erdos928.real_count_difference_bound
#print axioms Erdos928.density_difference_tendsto_zero
#print axioms Erdos928.density_transfer
#print axioms Erdos928.problem928_of_jointDickmanLaw
