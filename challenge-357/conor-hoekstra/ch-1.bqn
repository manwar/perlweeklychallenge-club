# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/357-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

ZPad     ← { 𝕩∾˜"0"⥊˜4-≠𝕩 }
KIter    ← { (∨-○•BQN∧)⌽ZPad•Fmt𝕩 }
Kaprekar ← { ×∘≠◶¯1‿⊑/6174=KIter∘⊣`8⥊𝕩 }

# Tests
u.UnitTest (Kaprekar 3524) ≡ 3
u.UnitTest (Kaprekar 6174) ≡ 0
u.UnitTest (Kaprekar 9998) ≡ 5
u.UnitTest (Kaprekar 1001) ≡ 4
u.UnitTest (Kaprekar 9000) ≡ 4
u.UnitTest (Kaprekar 1111) ≡ ¯1
