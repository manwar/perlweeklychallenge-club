# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/299-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
s  ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

ReplaceWords ← { s.Unwords (s.Words𝕩) { m ← 𝕨⊸fn.IsPrefix¨𝕩 ⋄ ((<𝕨)⥊˜≠)⌾(m⊸/)𝕩 }´𝕨 }

# Tests
a‿b ← "the cattle was rattle by the battery"‿"the cat was rat by the bat"
c‿d ← "the manager was hit by a biker"‿"the man was hit by a bike"
u.UnitTest ("cat"‿"bat"‿"rat" ReplaceWords a) ≡ b
u.UnitTest ("a"‿"b"‿"c" ReplaceWords "aab aac and cac bab") ≡ "a a a c b"
u.UnitTest ("man"‿"bike" ReplaceWords c) ≡ d
