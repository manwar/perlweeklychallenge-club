# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/344-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

ArrayFormation ← { ∨´𝕨⊸≡∘∾˘fn.Permutations𝕩 }

# Tests
u.UnitTest (   ⟨1, 2, 3, 4⟩ ArrayFormation ⟨⟨2,3⟩, ⟨1⟩, ⟨4⟩⟩)   ≡ 1
u.UnitTest (   ⟨1, 2, 3, 4⟩ ArrayFormation ⟨⟨1,3⟩, ⟨2,4⟩⟩)      ≡ 0
u.UnitTest (⟨5, 8, 2, 9, 1⟩ ArrayFormation ⟨⟨9,1⟩, ⟨5,8⟩, ⟨2⟩⟩) ≡ 1
u.UnitTest (      ⟨1, 2, 3⟩ ArrayFormation ⟨⟨1⟩, ⟨3⟩⟩)          ≡ 0
u.UnitTest (      ⟨7, 4, 6⟩ ArrayFormation ⟨⟨7,4,6⟩⟩)           ≡ 1
