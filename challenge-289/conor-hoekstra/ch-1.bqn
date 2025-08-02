# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/289-1.bqn

ThirdMaximum ← 2⊑((2⥊⌈´)∾˜⍷∘∨)

# Tests
•Show ThirdMaximum ⟨5, 6, 4, 1⟩ # 4
•Show ThirdMaximum ⟨4, 5⟩       # 5
•Show ThirdMaximum ⟨1, 2, 2, 3⟩ # 1
