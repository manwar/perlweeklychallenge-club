# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/347-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

Hj     ← '-'⊸s.Join
Last   ← (2-˜≠)◶⟨⋈,⋈,2⊸(↑⋈↓)⟩
Rec    ← { 4≥≠𝕩 ? ⋈ Hj Last 𝕩 ; (⋈3↑𝕩)∾𝕊3↓𝕩 } 
Format ← Hj·Rec(¬∊⟜"- ")⊸/

# Tests
u.UnitTest (Format "1-23-45-6")   ≡ "123-456"
u.UnitTest (Format "1234")        ≡ "12-34"
u.UnitTest (Format "12 345-6789") ≡ "123-456-789"
u.UnitTest (Format "123 4567")    ≡ "123-45-67"
u.UnitTest (Format "123 456-78")  ≡ "123-456-78"
