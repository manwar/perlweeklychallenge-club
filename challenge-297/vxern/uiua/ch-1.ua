GetMaxLength ← (
  /◇⊂ ⍚(≡□◫) ⊙¤ +1°⊏ # Get all the possible combinations of subarrays.
  ≡◇⊃(/+⌕1|/+⌕0)     # Find the number of 1s and the number of 0s.
  ▽⊸=                # Keep those results where the number of 1s and 0s is equivalent.
  ⬚0/↥               # Get the largest value.
  ×2                 # Multiply it by 2.
)

⍤⤙≍ 2 GetMaxLength [1 0]
⍤⤙≍ 2 GetMaxLength [0 1 0]
⍤⤙≍ 0 GetMaxLength [0 0 0 0 0]
⍤⤙≍ 4 GetMaxLength [0 1 0 0 1 0]
