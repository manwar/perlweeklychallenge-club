# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/278-2.bqn

ReverseWord ← (⊑0∾˜1+/∘=)(∧∘↑∾↓)⊢

# Tests
•Show 'e' ReverseWord "challenge"   # "acehllnge"
•Show 'a' ReverseWord "programming" # "agoprrmming"
•Show 'b' ReverseWord "champion"    # "champion"
