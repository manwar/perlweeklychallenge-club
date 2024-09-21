# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/082-1.bqn

Factors       ← (1+↕)(⊣/˜0=|)⊢
CommonFactors ← (∊/⊣)○Factors

# Tests
•Show 12 CommonFactors 18
•Show 18 CommonFactors 23
