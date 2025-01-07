# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/303-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

ThreeDigitInts ← { (¬2⊸|)⊸/∧⍷•BQN¨∾¨•Fmt¨¨×∘⊑¨⊸/3 fn.ChooseWR𝕩 }

# Tests
u.UnitTest (ThreeDigitInts ⟨2,1,3,0⟩)   ≡ ⟨102, 120, 130, 132, 210, 230, 302, 310, 312, 320⟩
u.UnitTest (ThreeDigitInts ⟨2,2,8,8,2⟩) ≡ ⟨222, 228, 282, 288, 822, 828, 882⟩
