# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/275-2.bqn

⟨IsDigit⟩ ⇐ •Import "../lib/string.bqn"

ReplaceDigits ← {IsDigit𝕩?•BQN⥊𝕩;0}¨+{IsDigit𝕩?𝕨;𝕩}`

# Tests
•Show ReplaceDigits "a1c1e1"   # 'abcdef'
•Show ReplaceDigits "a1b2c3d4" # 'abbdcfdh'
•Show ReplaceDigits "b2b"      # 'bdb'
•Show ReplaceDigits "a16z"     # 'abgz'
