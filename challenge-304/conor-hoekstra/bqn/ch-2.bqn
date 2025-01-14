# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/304-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

MaximumAverage ← ⌈´·(+´÷≠)˘↕

# Tests
u.UnitTest (4 MaximumAverage ⟨1, 12, -5, -6, 50, 3⟩) ≡ 12.75
u.UnitTest (1 MaximumAverage ⟨5⟩) ≡ 5
