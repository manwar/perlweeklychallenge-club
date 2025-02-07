# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/307-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

CheckOrder ← /≠⟜∧

# Tests
u.UnitTest (CheckOrder ⟨5, 2, 4, 3, 1⟩) ≡ ⟨0, 2, 3, 4⟩
u.UnitTest (CheckOrder ⟨1, 2, 1, 1, 3⟩) ≡ ⟨1, 3⟩
u.UnitTest (CheckOrder ⟨3, 1, 3, 2, 3⟩) ≡ ⟨0, 1, 3⟩
