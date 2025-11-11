# uiua 0.17.3

FormatPhoneNumber ← |1 (
  ▽⊸(¬∊"- ")
  ⌈÷₃-₄⊸⧻
  ⍥(⊙˜$"__-"⊃↘↙3) ⊙⊙""
  ⨬∘($"_-_"⊃↙↘2) =₄⊸⧻
  ˜⊂
)

┌─╴test
  ⍤⤙≍ "123-456" FormatPhoneNumber "1-23-45-6"
  ⍤⤙≍ "12-34" FormatPhoneNumber "1234"
  ⍤⤙≍ "123-456-789" FormatPhoneNumber "12 345-6789"
  ⍤⤙≍ "123-45-67" FormatPhoneNumber "123 4567"
  ⍤⤙≍ "123-456-78" FormatPhoneNumber "123 456-78"
└─╴
