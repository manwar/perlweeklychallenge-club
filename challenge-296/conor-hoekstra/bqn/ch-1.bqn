# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/296-1.bqn

⟨Group⟩ ⇐ •Import "../lib/fun.bqn"

CompressString ← ∾·((1⊸=◶•Fmt‿""≠)∾⊑)¨Group

# Tests
•Show CompressString "abbc"           # "a2bc"
•Show CompressString "aaabccc"        # "3ab3c"
•Show CompressString "abcc"           # "ab2c"
•Show CompressString "abccaa"         # "ab2c2a"
•Show CompressString "aaaaaaaaaaabcc" # "11ab2c"
