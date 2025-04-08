# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/316-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

IsSubsequence ← { ∨´𝕨⊸≡¨fn.PowerSet 𝕩 }

# Tests
u.UnitTest ("uvw" IsSubsequence "bcudvew")    ≡ 1
u.UnitTest ("aec" IsSubsequence "abcde")      ≡ 0
u.UnitTest ("sip" IsSubsequence "javascript") ≡ 1
