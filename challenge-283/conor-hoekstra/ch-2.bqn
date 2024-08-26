# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/283-2.bqn

DigitCountValue ← (+˝(=⌜⟜↕≠))⊸≡

# Tests
•Show DigitCountValue ⟨1, 2, 1, 0⟩ # 1
•Show DigitCountValue ⟨0, 3, 0⟩    # 0
