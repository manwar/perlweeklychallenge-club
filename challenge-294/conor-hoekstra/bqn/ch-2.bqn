# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/294-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

NextPermutation ← fn.Next

# Implementation:
# Next ⇐ {
#     i ← ⊢´/<_AdjMap𝕩 ⋄ x ← i⊑𝕩
#     j ← ⊢´/𝕩>x       ⋄ y ← j⊑𝕩
#     ⌽⌾((1+i)⊸↓)y⌾(i⊸⊑)x⌾(j⊸⊑)𝕩
# }

# Tests
u.UnitTest (NextPermutation ⟨1,2,3⟩)       ≡ ⟨1,3,2⟩
u.UnitTest (NextPermutation ⟨2,1,3⟩)       ≡ ⟨2,3,1⟩
u.UnitTest (NextPermutation ⟨1,3,2⟩)       ≡ ⟨2,1,3⟩
u.UnitTest (NextPermutation ⟨3,1,2⟩)       ≡ ⟨3,2,1⟩
u.UnitTest (NextPermutation ⟨2,3,1⟩)       ≡ ⟨3,1,2⟩
u.UnitTest (NextPermutation ⟨2,4,1,7,5,0⟩) ≡ ⟨2,4,5,0,1,7⟩
