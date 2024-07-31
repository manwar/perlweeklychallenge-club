# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/273-1.bqn

⟨Round⟩ ⇐ •Import "../lib/math.bqn"

Percentage ← (Round 100×+´÷≠)=

# Tests
•Show      "perl" Percentage 'e' # 25
•Show      "java" Percentage 'a' # 50
•Show    "python" Percentage 'm' # 0
•Show       "ada" Percentage 'a' # 67
•Show "ballerina" Percentage 'l' # 22
•Show  "analitik" Percentage 'k' # 13
