⎕IO←1

ArmstrongNumber←{0,⍸n=+⌿d*⍤1+⌿∨⍀×d←⍺⊥⍣¯1⊢n←⍳⍵}

⎕←10 ArmstrongNumber 1000
⎕← 7 ArmstrongNumber 1000
⎕←16 ArmstrongNumber 1000
