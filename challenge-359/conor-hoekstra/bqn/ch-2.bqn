# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/359-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

StringReduction ← (∾·(1=≠¨)⊸/fn.Group)⍟≠

# Tests
u.UnitTest (StringReduction "aabbccdd") ≡ ""
u.UnitTest (StringReduction "abccba") ≡ ""
u.UnitTest (StringReduction "abcdef") ≡ "abcdef"
u.UnitTest (StringReduction "aabbaeaccdd") ≡ "aea"
u.UnitTest (StringReduction "mississippi") ≡ "m"
