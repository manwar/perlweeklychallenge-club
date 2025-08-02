# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/279-2.bqn

⟨IsVowel⟩ ⇐ •Import "../lib/string.bqn"

SplitString ← ¬2|·+´IsVowel¨

# Tests
•Show SplitString "perl"         # 0
•Show SplitString "book"         # 1
•Show SplitString "good morning" # 1
