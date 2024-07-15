# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/272-2.bqn

# Solution 1 (Explicit)
ScoreOfString ← {+´|-´˘2↕'a'-˜𝕩}

# Solution 2 (Tacit)
ScoreOfString ← +´·|·-´˘2↕-⟜'a'

# Solution 3 (More Functions)
Ord    ← -⟜'a'
Deltas ← -´˘2↕⊢
ScoreOfString ← +´·|·Deltas Ord

ScoreOfString "hello" # 13
ScoreOfString "perl"  # 30
ScoreOfString "raku"  # 37
