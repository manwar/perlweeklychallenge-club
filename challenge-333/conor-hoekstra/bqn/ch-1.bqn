# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/333-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

StraightLine ← { ∧´≡´¨(⌽-´2↑𝕩)⊸×¨(⊑𝕩)⊸-¨(1↓𝕩) }

# Tests
u.UnitTest (StraightLine ⟨⟨2, 1⟩, ⟨2, 3⟩, ⟨2, 5⟩⟩)  ≡ 1
u.UnitTest (StraightLine ⟨⟨1, 4⟩, ⟨3, 4⟩, ⟨10, 4⟩⟩) ≡ 1
u.UnitTest (StraightLine ⟨⟨0, 0⟩, ⟨1, 1⟩, ⟨2, 3⟩⟩)  ≡ 0
u.UnitTest (StraightLine ⟨⟨1, 1⟩, ⟨1, 1⟩, ⟨1, 1⟩⟩)  ≡ 1
u.UnitTest (StraightLine ⟨⟨1000000, 1000000⟩, ⟨2000000, 2000000⟩, ⟨3000000, 3000000⟩⟩) ≡ 1
