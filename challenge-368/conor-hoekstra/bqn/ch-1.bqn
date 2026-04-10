# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/368-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

W ← { 𝕩/˜𝕨≠↕≠𝕩 }
Mib ← { •Fmt⌈´•BQN¨ W⟜𝕩¨/𝕨=𝕩 }

# Tests
u.UnitTest ('5' Mib "15456") ≡ "1546"
u.UnitTest ('3' Mib "7332") ≡ "732"
u.UnitTest ('2' Mib "2231") ≡ "231"
u.UnitTest ('5' Mib "543251") ≡ "54321"
u.UnitTest ('1' Mib "1921") ≡ "921"
