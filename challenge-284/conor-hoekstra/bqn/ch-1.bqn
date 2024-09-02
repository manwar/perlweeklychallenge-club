# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/284-1.bqn

LuckyInteger ← ⌈´¯1∾˜⊢(⊢/˜⊢=·+˝=⌜)⍷

# Tests
•Show LuckyInteger ⟨2, 2, 3, 4⟩       # 2
•Show LuckyInteger ⟨1, 2, 2, 3, 3, 3⟩ # 3
•Show LuckyInteger ⟨1, 1, 1, 3⟩       # -1

