# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/322-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

RankArray  ← { 1+𝕩⊐˜∧⍷𝕩 } # explicit
RankArray2 ← 1+∧∘⍷⊐⊢ # tacit

# Tests
u.UnitTest (RankArray  55‿22‿44‿33) ≡ 4‿1‿3‿2
u.UnitTest (RankArray  10‿10‿10)    ≡ 1‿1‿1
u.UnitTest (RankArray  5‿1‿1‿4‿3)   ≡ 4‿1‿1‿3‿2
u.UnitTest (RankArray2 55‿22‿44‿33) ≡ 4‿1‿3‿2
u.UnitTest (RankArray2 10‿10‿10)    ≡ 1‿1‿1
u.UnitTest (RankArray2 5‿1‿1‿4‿3)   ≡ 4‿1‿1‿3‿2
