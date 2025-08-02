# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/280-2.bqn

AsteriskCount  ← +´'*'=(¬·≠`'|'=⊢)⊸/ # Solution 1
AsteriskCount2 ← +´(¬·≠`'|'=⊢)×'*'⊸= # Solution 2

# Tests
•Show AsteriskCount  "p|*e*rl|w**e|*ekly|"           # 2
•Show AsteriskCount  "perl"                          # 0
•Show AsteriskCount  "th|ewe|e**|k|l***ych|alleng|e" # 5
•Show AsteriskCount2 "p|*e*rl|w**e|*ekly|"           # 2
•Show AsteriskCount2 "perl"                          # 0
•Show AsteriskCount2 "th|ewe|e**|k|l***ych|alleng|e" # 5
