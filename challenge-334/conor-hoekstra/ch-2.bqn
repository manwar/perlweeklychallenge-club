# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/334-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Dist ← +´|∘-
NearestValidPoint ← { x‿y𝕊p:
    v ← (y⍷⊢´¨p)∨x⍷⊑¨p # valid points
    { 0=+´v ? ¯1 ; ⊑p⊐(v/p)/˜⌊´⊸=(x∾y)⊸Dist¨v/p }
}

# Tests
u.UnitTest (3‿4 NearestValidPoint ⟨1‿2, 3‿1, 2‿4, 2‿3⟩) ≡ 2
u.UnitTest (2‿5 NearestValidPoint ⟨3‿4, 2‿3, 1‿5, 2‿5⟩) ≡ 3
u.UnitTest (1‿1 NearestValidPoint ⟨2‿2, 3‿3, 4‿4⟩)      ≡ ¯1
u.UnitTest (0‿0 NearestValidPoint ⟨0‿1, 1‿0, 0‿2, 2‿0⟩) ≡ 0
