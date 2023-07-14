maxWords ← {⌈/≢¨' '∘(≠⊆⊢)¨⍵} ⍝ Solution 1
maxWords ← {1+⌈/≢¨⍵/⍨¨' '=⍵} ⍝ Solution 2
maxWords ← {1+⌈/+/¨' '=⍵}    ⍝ Solution 3
maxWords ← {⌈/≢¨⊆⍨¨~' '=⍵}  ⍝ Solution 4
