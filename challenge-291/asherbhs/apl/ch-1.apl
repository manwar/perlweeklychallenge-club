⎕IO←0

MiddleIndex1←{¯1⊣⍣(i=≢⍵)i←1⍳⍨=∘⌽⍥(0,¯1↓+\)∘⌽⍨⍵}
MiddleIndex2←{         ⊃¯1,⍨⍸=∘⌽⍥(0,¯1↓+\)∘⌽⍨⍵}

⎕←(MiddleIndex1,MiddleIndex2) 2 3 ¯1 8 4
⎕←(MiddleIndex1,MiddleIndex2) 1 ¯1 4
⎕←(MiddleIndex1,MiddleIndex2) 2 5
