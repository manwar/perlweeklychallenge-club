# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/311-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

GroupDigitSum ← { 𝕨⊸{ 𝕨≥≠𝕩 ? 𝕩 ; 𝕨𝕊+´¨𝕨fn.Chunk𝕩 }⌾(-⟜'0'¨)𝕩 }

# Tests
u.UnitTest (3 GroupDigitSum "111122333")    ≡ "359"
u.UnitTest (2 GroupDigitSum "1222312")      ≡ "76"
u.UnitTest (4 GroupDigitSum "100012121001") ≡ "162"
