# https://theweeklychallenge.org/blog/perl-weekly-challenge-324/#TASK2

# Uiua 0.17.0-dev.1

# Experimental!
~ "git: github.com/Omnikar/uiua-math" ~ PSet

# a XOR b = (a OR b) - (a AND b)
Xor ← °⋯-⬚0⊃×∨∩⋯

TotalXor ← /+ ≡◇∧Xor⊙0 PSet

┌─╴🧪
  ⍤⤙≍ 6 TotalXor [1 3]
  ⍤⤙≍ 28 TotalXor [5 1 6]
  ⍤⤙≍ 480 TotalXor [3 4 5 6 7 8]
└─╴
