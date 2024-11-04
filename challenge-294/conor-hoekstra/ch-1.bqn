# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/294-1.bqn

⟨_ChunkBy⟩ ⇐ •Import "../lib/fun.bqn"

ConsecutiveSequence ← {⌈´¯1∾˜1⊸<⊸/≠¨(¯1=-)_ChunkBy⍷∧𝕩}

# Tests
•Show ConsecutiveSequence ⟨10, 4, 20, 1, 3, 2⟩           # 4
•Show ConsecutiveSequence ⟨0, 6, 1, 8, 5, 2, 4, 3, 0, 7⟩ # 9
•Show ConsecutiveSequence ⟨10, 30, 20⟩                   # -1
