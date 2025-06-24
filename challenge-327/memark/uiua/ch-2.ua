# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/#TASK2

# Uiua 0.17.0-dev.1

MinAbsDiff ← (
  ⧅>2
  ⌵⊸≡/-
  ▽=⊸/↧
  ⍆≡⍆
)

┌─╴🧪
  ⍤.≍ [1_2 2_3 3_4] MinAbsDiff [4 1 2 3]
  ⍤.≍ [1_3] MinAbsDiff [1 3 7 11 15]
  ⍤.≍ [1_3 3_5] MinAbsDiff [1 5 3 8]
└─╴
