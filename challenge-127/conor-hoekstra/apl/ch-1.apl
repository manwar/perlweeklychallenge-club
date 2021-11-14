
⍝ Solution 1 (using intersection)
solution ← ⍬≡∩

⍝ Solution 2 (using outerProduct)
solution ← ∧/⍤~⍤∊∘.=

⍝ Tests
4 6 7 8 9 solution 1 2 5 3 4 ⍝ prints 0
0 2 4 6 8 solution 1 3 5 7 9 ⍝ prints 1
