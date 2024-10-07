# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/290-1.bqn

DoubleExists ← ∨´2⊸×⊸∊

# Tests
•Show DoubleExists ⟨6, 2, 3, 3⟩ # 1
•Show DoubleExists ⟨3, 1, 4, 13⟩ # 0
•Show DoubleExists ⟨2, 1, 4, 2⟩ # 1
