# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/283-1.bqn

UniqueNumber ← ⊑·/1=·≠¨⊔

# Tests
•Show UniqueNumber ⟨3, 3, 1⟩          # 1
•Show UniqueNumber ⟨3, 2, 4, 2, 4⟩    # 3
•Show UniqueNumber ⟨1⟩                # 1
•Show UniqueNumber ⟨4, 3, 1, 1, 1, 4⟩ # 3
