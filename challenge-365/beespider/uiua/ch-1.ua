# uiua 0.18.0

# ? String Integer
AlphabetIndexDigitSum ← (
  ˜⍥(/+⊥10) ⊓(/++ ⊃(⌊÷10)◿₁₀ +1-@a|-1)
)

┌─╴test
  ⍤⤙≍ 6 AlphabetIndexDigitSum "abc" 1
  ⍤⤙≍ 9 AlphabetIndexDigitSum "az" 2
  ⍤⤙≍ 6 AlphabetIndexDigitSum "cat" 1
  ⍤⤙≍ 8 AlphabetIndexDigitSum "dog" 2
  ⍤⤙≍ 6 AlphabetIndexDigitSum "perl" 3
└─╴
