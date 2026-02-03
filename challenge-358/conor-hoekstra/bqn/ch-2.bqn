# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/358-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Decrypt ← { (26|𝕨⊸+)⌾(-⟜'a') 𝕩 }

# Tests
u.UnitTest ( 1 Decrypt "abc")   ≡ "bcd"
u.UnitTest ( 2 Decrypt "xyz")   ≡ "zab"
u.UnitTest (27 Decrypt "abc")   ≡ "bcd"
u.UnitTest ( 5 Decrypt "hello") ≡ "mjqqt"
u.UnitTest (26 Decrypt "perl")  ≡ "perl"
