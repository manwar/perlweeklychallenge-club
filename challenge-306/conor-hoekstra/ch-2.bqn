# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/306-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

LastElement ← { 1≥≠𝕩 ? ⊑𝕩∾0 ; 𝕊(2↓s)∾≠´◶⟨⟩‿(⋈∘-´)2↑s ← ∨𝕩 }

# Tests
u.UnitTest (LastElement ⟨3, 8, 5, 2, 9, 2⟩) ≡ 1
u.UnitTest (LastElement ⟨3, 2, 5⟩) ≡ 0
