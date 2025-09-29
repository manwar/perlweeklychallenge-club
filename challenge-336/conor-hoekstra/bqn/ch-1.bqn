# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/336-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

EqualGroup ← ((∧´0=⌊´⊸|)∧(2≤⌊´))·≠¨fn.Group

# Tests
u.UnitTest (EqualGroup ⟨1,1,2,2,2,2⟩)             ≡ 1
u.UnitTest (EqualGroup ⟨1,1,1,2,2,2,3,3⟩)         ≡ 0
u.UnitTest (EqualGroup ⟨5,5,5,5,5,5,7,7,7,7,7,7⟩) ≡ 1
u.UnitTest (EqualGroup ⟨1,2,3,4⟩)                 ≡ 0
u.UnitTest (EqualGroup ⟨8,8,9,9,10,10,11,11⟩)     ≡ 1
