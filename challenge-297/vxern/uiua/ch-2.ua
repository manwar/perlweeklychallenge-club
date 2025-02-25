GetMinimumNumberOfSwaps ← (
  ⟜([0 -1]⧻) # Find the minimum and maximum position.
  ⊗⊸[1 /↥]   # Find the positions of 1 and N.
  -⊃(        #
    /<       # Check whether 1 and N have to be swapped along the way.
  | /+⌵-     # Find the number of swaps required.
  )
)

⍤⤙≍ 2 GetMinimumNumberOfSwaps [2 1 4 3]
⍤⤙≍ 3 GetMinimumNumberOfSwaps [2 4 1 3]
⍤⤙≍ 0 GetMinimumNumberOfSwaps [1 3 2 4 5]
