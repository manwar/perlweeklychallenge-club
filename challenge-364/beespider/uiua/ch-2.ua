# uiua 0.18.0

GoalParser ← ⍜⊜∘≡⋅"al"⊸⦷"(al)" ⍜⊜∘≡⋅@o⊸⦷"()"

┌─╴test
  ⍤⤙≍ "Goal" GoalParser "G()(al)"
  ⍤⤙≍ "Gooooal" GoalParser "G()()()()(al)"
  ⍤⤙≍ "alGaloo" GoalParser "(al)G(al)()()"
  ⍤⤙≍ "oGoG" GoalParser "()G()G"
  ⍤⤙≍ "alalGoo" GoalParser "(al)(al)G()()"
└─╴