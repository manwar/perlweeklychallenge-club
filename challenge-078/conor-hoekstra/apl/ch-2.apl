LeftRotate ← ↑⌽¨∘⊂

⍝ Tests

3 4 LeftRotate 10 20 30 40 50
⍝ Output:
⍝     [40 50 10 20 30]
⍝     [50 10 20 30 40]

1 3 4 LeftRotate 7 4 2 6 3
⍝ Output:
⍝     [4 2 6 3 7]
⍝     [6 3 7 4 2]
⍝     [3 7 4 2 6]
