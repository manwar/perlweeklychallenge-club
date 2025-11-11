# uiua 0.17.2

MagicExpression ← (
  ⧅⋅⧻⊙{@*@+@-""}-₁⊸⧻             # separator combinations
  ⍚⌟(/◇⊂♭⍉⊟⊂□"")                 # interleave
  ▽⊸≡◇(≍⊸⍚⍜⋕∘⊜□⊸≥@0)             # leading zeros
  ˜▽⊙=⟜≡◇(/+⊕(/×⊜⋕⊸≠@*)\+⊸∊"-+") # eval
)

┌─╴test
  ⍤⤙≍{"1*2*3" "1+2+3"} MagicExpression "123" 6
  ⍤⤙≍{"1*0+5" "10-5"} MagicExpression "105" 5
  ⍤⤙≍{"2*3+2" "2+3*2"} MagicExpression "232" 8
  ⍤⤙≍{"1*2*3+4" "1+2+3+4"} MagicExpression "1234" 10
  ⍤⤙≍{"1+0*0+1" "1+0+0+1" "1+0-0+1"
      "1-0*0+1" "1-0+0+1" "1-0-0+1"
  } MagicExpression "1001" 2
└─╴
