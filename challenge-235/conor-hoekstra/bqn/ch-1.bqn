DupZeroes ← {(≠𝕩)↑𝕩/˜1+0=𝕩} # Explicit
DupZeroes ← ≠↑(1+0=⊢)⊸/     # Tacit

# Tests
DupZeroes ⟨1,0,2,3,0,4,5,0⟩ # ⟨ 1 0 0 2 3 0 0 4 ⟩
DupZeroes ⟨1,2,3⟩           # ⟨ 1 2 3 ⟩
DupZeroes ⟨0,3,0,4,5⟩       # ⟨ 0 0 3 0 0 ⟩
