# uiua 0.18.0

ValidTokenCount ← /+≡◇(⧻regex"^[a-z]+(?:-[a-z]+)?[!.,]?$") ⊜□⊸≠@\s

┌─╴test
  ⍤⤙≍ 3 ValidTokenCount "cat and dog"
  ⍤⤙≍ 2 ValidTokenCount "a-b c! d,e"
  ⍤⤙≍ 4 ValidTokenCount "hello-world! this is fun"
  ⍤⤙≍ 2 ValidTokenCount "ab- cd-ef gh- ij!"
  ⍤⤙≍ 2 ValidTokenCount "wow! a-b-c nice."
└─╴
