PalindromicTree ← {1↓(⌽≡⊢)¨⊸/˜⍷∾´↑¨↓𝕩}

# Tests
PalindromicTree "redivider" # ⟨ "r" "redivider" "e" "edivide" "d" "divid" "i" "ivi" "v" ⟩
PalindromicTree "deific"    # ⟨ "d" "e" "i" "ifi" "f" "c" ⟩
PalindromicTree "rotors"    # ⟨ "r" "rotor" "o" "oto" "t" "s" ⟩
PalindromicTree "challenge" # ⟨ "c" "h" "a" "l" "ll" "e" "n" "g" ⟩
PalindromicTree "champion"  # ⟨ "c" "h" "a" "m" "p" "i" "o" "n" ⟩
PalindromicTree "christmas" # ⟨ "c" "h" "r" "i" "s" "t" "m" "a" ⟩
