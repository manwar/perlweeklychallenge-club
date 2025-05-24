# https://theweeklychallenge.org/blog/perl-weekly-challenge-321/#TASK2

# Uiua 0.17.0-dev.1

RemoveOneHash ← (
  ≠∞⬚∞⊸⊗@#
  ⍥(:⊸°⊏
    ⊗@#
    ⊂⊸-₁
    ⍜⊏≡⋅[]
    ⊏
  )
)
BackspaceCompare ← ≍∩(⍥RemoveOneHash∞)

┌─╴🧪
  ⍤⤙≍ 1 BackspaceCompare "ab#c" "ad#c"
  ⍤⤙≍ 1 BackspaceCompare "ab##" "a#b#"
  ⍤⤙≍ 0 BackspaceCompare "a#b" "c"
└─╴
