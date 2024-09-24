# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/288-1.bqn

# Slow One-Line Solution
ClosestPalindrome ← {⊑(⌽⊸≡•Fmt)¨⊸/∾<˘⍉>((•BQN𝕩)(-⋈+)(1+↕))10⋆≠𝕩}

# Faster Solution
Find ← { 𝕩 < 0 ? ¯∞ ; ⌽⊸≡•Fmt 𝕩 ? 𝕩 ; 𝕨 𝕊 𝕨 + 𝕩 }
ClosestPalindrome2 ← { ⊑(⌊´⊸=·|t-⊢)⊸/¯1 ⋈○(Find⟜(+⟜(t←•BQN𝕩))) 1 }

# Tests
•Show ClosestPalindrome "123"     # "121"
•Show ClosestPalindrome "2"       #"1"
•Show ClosestPalindrome "1400"    # "1441"
•Show ClosestPalindrome "1001"    # "999"
•Show ClosestPalindrome "999"     # "10001"
•Show ClosestPalindrome "0"       # "1"

•Show ClosestPalindrome2 "123"     # "121"
•Show ClosestPalindrome2 "2"       #"1"
•Show ClosestPalindrome2 "1400"    # "1441"
•Show ClosestPalindrome2 "1001"    # "999"
•Show ClosestPalindrome2 "999"     # "10001"
•Show ClosestPalindrome2 "0"       # "1"
•Show ClosestPalindrome2 "1231234" # "12311321"
