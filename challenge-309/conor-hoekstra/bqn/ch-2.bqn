# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/309-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

MinDiff ← ⌊´·fn.Deltas∧

# Tests
u.UnitTest (MinDiff ⟨1, 5, 8, 9⟩) ≡ 1
u.UnitTest (MinDiff ⟨9, 4, 1, 7⟩) ≡ 2
