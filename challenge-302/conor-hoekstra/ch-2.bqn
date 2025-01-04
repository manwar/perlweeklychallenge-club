# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/302-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

MinimumStart  ← { 1⌈1-⌊´+`𝕩 } # Explicit
MinimumStart2 ← 1⌈1-·⌊´+`     # Tacit

# Tests
u.UnitTest (MinimumStart ⟨-3, 2, -3, 4, 2⟩) ≡ 5
u.UnitTest (MinimumStart ⟨1, 2⟩) ≡ 1
u.UnitTest (MinimumStart ⟨1, -2, -3⟩) ≡ 5
u.UnitTest (MinimumStart2 ⟨-3, 2, -3, 4, 2⟩) ≡ 5
u.UnitTest (MinimumStart2 ⟨1, 2⟩) ≡ 1
u.UnitTest (MinimumStart2 ⟨1, -2, -3⟩) ≡ 5
