# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/342-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
s  ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

Valid ← ∧´·fn.Differ s.IsDigit¨
BalanceString ← { ⊑(⋈"")∾˜∧<˘Valid˘⊸/fn.Permutations 𝕩 }

# Tests
u.UnitTest (BalanceString "a0b1c2")  ≡ "0a1b2c"
u.UnitTest (BalanceString "abc12")   ≡ "a1b2c"
u.UnitTest (BalanceString "0a2b1c3") ≡ "0a1b2c3"
u.UnitTest (BalanceString "1a23")    ≡ ""
u.UnitTest (BalanceString "ab123")   ≡ "1a2b3"
