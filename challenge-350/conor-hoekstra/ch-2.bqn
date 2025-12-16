# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/350-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

Pairs ← { +´(∧•Fmt𝕩)⊸≡¨∧∘•Fmt¨𝕩×2+↕8 }
ShufflePairs ← { 𝕊a‿b‿c: +´c≤Pairs¨a+↕1+b-a }

# Tests
u.UnitTest (ShufflePairs ⟨1, 1000, 1⟩) ≡ 0
u.UnitTest (ShufflePairs ⟨1500, 2500, 1⟩) ≡ 3
# u.UnitTest (ShufflePairs ⟨1000000, 1500000, 5⟩) ≡ 2
# u.UnitTest (ShufflePairs ⟨13427000, 14100000, 2⟩) ≡ 11
u.UnitTest (ShufflePairs ⟨1030, 1130, 1⟩) ≡ 2
