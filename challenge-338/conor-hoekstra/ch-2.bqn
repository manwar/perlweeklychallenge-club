# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/338-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

MaxDistance ← ⌈´·⥊·|-⌜

# Tests
u.UnitTest (   ⟨4,5,7⟩ MaxDistance ⟨9,1,3,4⟩)     ≡ 6
u.UnitTest ( ⟨2,3,5,4⟩ MaxDistance ⟨3,2,5,5,8,7⟩) ≡ 6
u.UnitTest (⟨2,1,11,3⟩ MaxDistance ⟨2,5,10,2⟩)    ≡ 9
u.UnitTest (   ⟨1,2,3⟩ MaxDistance ⟨3,2,1⟩)       ≡ 2
u.UnitTest ( ⟨1,0,2,3⟩ MaxDistance ⟨5,0⟩)         ≡ 5
