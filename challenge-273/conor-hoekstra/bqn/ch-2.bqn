# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/273-2.bqn

BAfterA ← (⌈´∧⌈`⊸≡)'b'=⊢

# Tests
•Show BAfterA ¨ "aabb"‿"abab"‿"aaa"‿"bbb" # ⟨ 1 0 0 1 ⟩
