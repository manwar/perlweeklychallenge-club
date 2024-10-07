# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/290-2.bqn

⟨Digits⟩ ⇐ •Import "../lib/binary.bqn"

Luhn ← {
    d ← •BQN∘⥊¨𝕩 # digits
    p ← ⊑⌽xs     # payload
    m ← 1+2|↕≠𝕩  # mask
    p=10-10|+´∾Digits¨¯1↓m×xs
}

# Tests
•Show Luhn "17893729974"      # 1
•Show Luhn "4137894711755904" # 1 🤔 something wrong here
•Show Luhn "4137897411755904" # 0 🤔 something wrong here
