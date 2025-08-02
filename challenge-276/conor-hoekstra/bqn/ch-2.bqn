# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/276-2.bqn

MaxFreq ← (+´⌈´⊸=⊸×)·≠¨⊐⊸⊔

# Tests

•Show MaxFreq ⟨1, 2, 2, 4, 1, 5⟩ # 4
•Show MaxFreq ⟨1, 2, 3, 4, 5⟩    # 5
