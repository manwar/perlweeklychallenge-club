# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/337-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Row       ← { 1⊸+⌾(𝕨⊸⊏)𝕩 }
Col       ← ⍉Row⟜⍉
RowCol    ← { r‿c𝕊𝕩: r Row c Col 𝕩 }
OddMatrix ← { +´2|⥊(𝕨⥊0) RowCol´ 𝕩 }

# Tests
u.UnitTest (2‿3 OddMatrix ⟨⟨0,1⟩,⟨1,1⟩⟩)             ≡ 6
u.UnitTest (2‿2 OddMatrix ⟨⟨1,1⟩,⟨0,0⟩⟩)             ≡ 0
u.UnitTest (3‿3 OddMatrix ⟨⟨0,0⟩,⟨1,2⟩,⟨2,1⟩⟩)       ≡ 0
u.UnitTest (1‿5 OddMatrix ⟨⟨0,2⟩,⟨0,4⟩⟩)             ≡ 2
u.UnitTest (4‿2 OddMatrix ⟨⟨1,0⟩,⟨3,1⟩,⟨2,0⟩,⟨0,1⟩⟩) ≡ 8
