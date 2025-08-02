# https://theweeklychallenge.org/blog/perl-weekly-challenge-329/#TASK2

# Uiua 0.17.0-dev.1

IsNiceString ← (
  ◴
  ⊸≥@a
  ⍜▽(+@A-@a)
  ⬚@\0↯∞_2⍆
  ⍆
  /↧≡/=
)

LongestNiceString ← (
  ⇡⊸⧻
  ≡⌟(□↘)
  ⍚⧅□
  /◇⊂
  ▽⊸≡◇IsNiceString
  ⊸≡◇⧻
  °□⬚""⊢⊏⍖
)

┌─╴🧪
  ⍤.≍ "aaA" LongestNiceString "YaaAho"
  ⍤.≍ "cC" LongestNiceString "cC"
  ⍤.≍ "" LongestNiceString "A"
└─╴
