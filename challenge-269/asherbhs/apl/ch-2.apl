⎕IO←0

DistributeElements←{⊃,/⊃{(⊂⍺,⍨⊃)@(≤/⊃⍤⌽¨⍵)⊢⍵}/(⌽2↓⍵),⊂,¨2↑⍵}

⎕←DistributeElements 2 1 3 4 5
⎕←DistributeElements 3 2 4
⎕←DistributeElements 5 4 3 8
