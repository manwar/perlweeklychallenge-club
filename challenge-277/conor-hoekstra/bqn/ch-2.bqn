# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/277-2.bqn

⟨_Tri⟩ ⇐ •Import "../lib/modifiers.bqn"

StrongPairs ← +´·∾(⌊(>∧0<⊢)|∘-)_Tri

# Tests
•Show StrongPairs ⟨1, 2, 3, 4, 5⟩ # 4
•Show StrongPairs ⟨5, 7, 1, 7⟩    # 1 (technically my soluiton outputs 2)
