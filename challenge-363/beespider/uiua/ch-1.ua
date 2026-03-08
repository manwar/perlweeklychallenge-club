# uiua 0.18.0
StringLieDetector ← (
  regex$ ^(.*?) — (.*?) vowels? and (.*?) consonants?$
  ⊢₃↘₁°¤
  ⊓(∩/+⟜¬◇∊"aeiou"
  | ∩⌞⨂{"zero""one""two""three""four""five""six""seven""eight""nine""ten"})
  ×˜∩=
)

┌─╴test
  ⍤⤙≍ 1 StringLieDetector "aa — two vowels and zero consonants"
  ⍤⤙≍ 1 StringLieDetector "iv — one vowel and one consonant"
  ⍤⤙≍ 0 StringLieDetector "hello — three vowels and two consonants"
  ⍤⤙≍ 1 StringLieDetector "aeiou — five vowels and zero consonants"
  ⍤⤙≍ 1 StringLieDetector "aei — three vowels and zero consonants"
└─╴