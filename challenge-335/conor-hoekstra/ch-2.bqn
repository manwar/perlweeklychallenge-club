# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/335-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"


# New Code
wins  ← 8‿3⥊0‿4‿8‿0‿1‿2‿3‿4‿5‿6‿7‿8‿0‿3‿6‿1‿4‿7‿2‿5‿8‿2‿4‿6
Play  ← { 𝕨⌾(𝕩⊸⊑)9⥊0 }
Pos   ← { +´3‿1×𝕩 }
State ← { ∧´⎉1⟨1,2⟩=⌜wins⊏𝕩 }
FindWinner ← {
    x ← +´1‿2×+´˘State ⌈´{ 𝕊p‿ab: ab Play Pos p }¨𝕩⋈¨1‿2⥊˜≠𝕩
    (1+x-9=≠𝕩)⊑⟨"Draw","Pending","A","B"⟩
}

# Tests
u.UnitTest (FindWinner ⟨0‿0,2‿0,1‿1,2‿1,2‿2⟩) ≡ "A"
u.UnitTest (FindWinner ⟨0‿0,1‿1,0‿1,0‿2,1‿0,2‿0⟩) ≡ "B"
u.UnitTest (FindWinner ⟨0‿0,1‿1,2‿0,1‿0,1‿2,2‿1,0‿1,0‿2,2‿2⟩) ≡ "Draw"
u.UnitTest (FindWinner ⟨0‿0,1‿1⟩) ≡ "Pending"
u.UnitTest (FindWinner ⟨1‿1,0‿0,2‿2,0‿1,1‿0,0‿2⟩) ≡ "B"
