# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/299-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

WordSearch ← { t𝕊grid:
    deltas ← ⟨0‿1,0‿¯1,1‿0,¯1‿0⟩
    Ib     ← ∧´(0‿0⊸≤)∾(≢grid)⊸> # in bounds
    Rec ← { pos𝕊l‿d: {
        ¬l fn.IsPrefix t ? 0 ; t=○≠l ? 1 ;
        npos ← (Ib∧{¬∨´⥊𝕩⊸≡¨d})¨⊸/ pos⊸+¨deltas
        ∨´Rec⟜⟨l∾pos⊑grid,d∾<pos⟩¨npos }
    }
    ∨´Rec⟜⟨"",⟨⟩⟩¨fn.I 1⥊˜≢grid
}

# Tests
u.UnitTest ( "BDCA" WordSearch 4‿4⥊"ABDECBCABAADDBBC") ≡ 1
u.UnitTest ( "ABAC" WordSearch 4‿4⥊"AABBCCBACAAABBBB") ≡ 0
u.UnitTest ("CCCAA" WordSearch 4‿4⥊"BABACCCCABABBBAA") ≡ 1
