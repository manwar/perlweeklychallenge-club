# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/354-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

ShiftGrid ← { (-𝕨)⊸⌽⌾∾𝕩 }

# Tests
u.UnitTest (1 ShiftGrid ⟨⟨1, 2, 3⟩,⟨4, 5, 6⟩,⟨7, 8, 9⟩⟩) ≡ ⟨⟨9, 1, 2⟩,⟨3, 4, 5⟩,⟨6, 7, 8⟩⟩
u.UnitTest (1 ShiftGrid ⟨⟨10, 20⟩,⟨30, 40⟩⟩) ≡ ⟨⟨40, 10⟩,⟨20, 30⟩⟩
u.UnitTest (1 ShiftGrid ⟨⟨1, 2⟩,⟨3, 4⟩,⟨5, 6⟩⟩) ≡ ⟨⟨6, 1⟩,⟨2, 3⟩,⟨4, 5⟩⟩
u.UnitTest (5 ShiftGrid ⟨⟨1, 2, 3⟩,⟨4, 5, 6⟩⟩) ≡ ⟨⟨2, 3, 4⟩,⟨5, 6, 1⟩⟩
u.UnitTest (1 ShiftGrid ⟨⟨1, 2, 3, 4⟩⟩) ≡ ⟨⟨4, 1, 2, 3⟩⟩
