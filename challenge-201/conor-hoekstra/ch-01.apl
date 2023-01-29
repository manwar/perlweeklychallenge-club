MissingNumbers ← {⍵~⍨0,⍳≢⍵}
      
⍝ Test
MissingNumbers 0 1 3 ⍝ 2
MissingNumbers 0 1   ⍝ 2
