# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/272-1.bqn

Join     ← {(≠𝕨)↓∾𝕨⊸∾¨𝕩}
Split    ← (¬-˜⊢×·+`»⊸>)∘≠⊔⊢
DefangIp ← "[.]" Join '.' Split ⊢

# Tests
DefangIp "1.1.1.1"     # "1[.]1[.]1[.]1"
DefangIp "255.101.1.0" # "255[.]101[.]1[.]0"
