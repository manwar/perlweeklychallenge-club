# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/328-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
s  ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

Good ← 1=·⌈´·≠¨fn.Group
R ← {
    t ← "?" s.Split 𝕩
    ¯1↓∾⥊⍉t≍'a'+•rand.Range¨ 26⥊˜≠t
}
Replace ← { ⊑Good¨⊸/R¨5⥊⋈𝕩 }

# Tests
u.UnitTest (Good Replace "a?z")         ≡ 1
u.UnitTest (Good Replace "pe?k")        ≡ 1
u.UnitTest (Good Replace "gra?te")      ≡ 1
u.UnitTest (Good Replace "he?lo?world") ≡ 1
