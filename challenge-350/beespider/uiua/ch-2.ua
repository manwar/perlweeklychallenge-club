BoundedRange ← ⍜(⌵-|⇡+₁)
ShufflePairs ← |3 (
  BoundedRange
  ≡⌞× ⇡₁9
  °⋕
  ≡°⊂
  ∩≡₀⍚⍆
  ≡(/+≡⌞◇≍)
  /+≤
)

┌─╴test
  ⍤⤙≍ 0 ShufflePairs 1 1000 1
  ⍤⤙≍ 3 ShufflePairs 1500 2500 1
  ⍤⤙≍ 2 ShufflePairs 1000000 1500000 5
  ⍤⤙≍ 11 ShufflePairs 13427000 14100000 2
  ⍤⤙≍ 2 ShufflePairs 1030 1130 1
└─╴
