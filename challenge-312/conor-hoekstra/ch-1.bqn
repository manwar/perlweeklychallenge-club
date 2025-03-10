# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/312-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

MinimumTime  ← { (≠𝕩)++´26⊸-⊸⌊|fn.Deltas 0∾49|-⟜'0'𝕩 } # Explicit
MinimumTime2 ← ≠+(+´·26⊸-⊸⌊·|·fn.Deltas 0∾49|-⟜'0')    # Tacit

# Tests
u.UnitTest (MinimumTime  "abc")  ≡ 5
u.UnitTest (MinimumTime  "bza")  ≡ 7
u.UnitTest (MinimumTime  "zjpc") ≡ 34
u.UnitTest (MinimumTime2 "abc")  ≡ 5
u.UnitTest (MinimumTime2 "bza")  ≡ 7
u.UnitTest (MinimumTime2 "zjpc") ≡ 34
