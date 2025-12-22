# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/353-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

chars ← '_'∾('0'+↕10)∾⥊"aA"+⌜↕26
cats  ← "electronics"‿"restaurant"‿"pharmacy"‿"grocery"
IsValidCode ← ×∘≠∧·∧´∊⟜chars
IsValidCategory ← ∊⟜cats
ValidateCoupon ← { 𝕊codes‿names‿status:
    a ← IsValidCode¨codes
    b ← ⊑IsValidCategory¨names
    c ← ⊑status
    a∧b∧c
}

# Tests
u.UnitTest (ValidateCoupon ⟨"A123", "B_456", "C789", "D@1", "E123"⟩‿⟨"electronics"‿"restaurant"‿"electronics"‿"pharmacy"‿"grocery"⟩‿⟨1‿0‿1‿1‿1⟩) ≡ ⟨1, 0, 1, 0, 1⟩
u.UnitTest (ValidateCoupon ⟨"Z_9", "AB_12", "G01", "X99", "test"⟩‿⟨"pharmacy"‿"electronics"‿"grocery"‿"electronics"‿"unknown"⟩‿⟨1‿1‿0‿1‿1⟩) ≡ ⟨1, 1, 0, 1, 0⟩
u.UnitTest (ValidateCoupon ⟨"_123", "123", "", "Coupon_A", "Alpha"⟩‿⟨"restaurant"‿"electronics"‿"electronics"‿"pharmacy"‿"grocery"⟩‿⟨1‿1‿0‿1‿1⟩) ≡ ⟨1, 1, 0, 1, 1⟩
u.UnitTest (ValidateCoupon ⟨"ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"⟩‿⟨"electronics"‿"electronics"‿"grocery"‿"grocery"⟩‿⟨1‿1‿1‿1⟩) ≡ ⟨1, 1, 1, 1⟩
u.UnitTest (ValidateCoupon ⟨"CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"⟩‿⟨"restaurant"‿"electronics"‿"grocery"‿"pharmacy"‿"electronics"⟩‿⟨1‿1‿1‿1‿0⟩) ≡ ⟨1, 1, 1, 1, 0⟩
