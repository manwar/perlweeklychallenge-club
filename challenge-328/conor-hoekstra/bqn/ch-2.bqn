# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/328-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Mask ← { ¬∊⊸∧32=|-´˘2↕-⟜'0'𝕩 }
Good ← ×∘≠◶1‿(∧´Mask)
Adj  ← { 2=≠𝕩 ? "" ; 𝕩/˜1∾˜¯1⊸⌽⊸∧Mask 𝕩 }
GoodString ← { Adj•_while_(¬Good) 𝕩 }

# Tests
u.UnitTest (GoodString "WeEeekly") ≡ "Weekly"
u.UnitTest (GoodString "abBAdD")   ≡ ""
u.UnitTest (GoodString "abc")      ≡ "abc"
