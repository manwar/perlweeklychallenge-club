# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/318-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

Groups ← (3≤≠¨)⊸/fn.Group

# Tests
u.UnitTest (Groups "abccccd")        ≡ ⋈"cccc"
u.UnitTest (Groups "aaabcddddeefff") ≡ "aaa"‿"dddd"‿"fff"
u.UnitTest (Groups "abcdd")          ≡ ""
