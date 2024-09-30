# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/289-2.bqn

⟨Words, Unwords⟩ ⇐ •Import "../lib/string.bqn"

Shuffle ← •rand.Deal∘≠⊸⊏
Jumble ← Unwords·Shuffle⌾(¯1↓1↓⊢)¨Words

# Tests
•Show Jumble "This is a bunch a text that should be jumbled"
