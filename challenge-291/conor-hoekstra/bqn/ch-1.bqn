# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/291-1.bqn

MiddleIndex  ← {⊑¯1∾˜/((»+`)=(»+`)⌾⌽)𝕩} # Explicit
MiddleIndex2 ← ⊑¯1∾˜·/(»+`)=(»+`)⌾⌽     # Tacit
MiddleIndex3 ← ⊑¯1∾˜·/(»+`){(𝔽=𝔽⌾⌽)𝕩}   # Tacit 2

# Tests
•Show MiddleIndex ⟨2, 3, -1, 8, 4⟩ # 3
•Show MiddleIndex ⟨1, -1, 4⟩       # 2
•Show MiddleIndex ⟨2, 5⟩           # -1

•Show MiddleIndex2 ⟨2, 3, -1, 8, 4⟩ # 3
•Show MiddleIndex2 ⟨1, -1, 4⟩       # 2
•Show MiddleIndex2 ⟨2, 5⟩           # -1

•Show MiddleIndex3 ⟨2, 3, -1, 8, 4⟩ # 3
•Show MiddleIndex3 ⟨1, -1, 4⟩       # 2
•Show MiddleIndex3 ⟨2, 5⟩           # -1
