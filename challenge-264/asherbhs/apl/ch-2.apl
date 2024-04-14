⎕IO←0

TargetArray←{⍺[⍋⍵++/¨⍵≥((1+⍳⍤≢)⊂⍤↓⍤0 1⊢)⍵]}

⎕←0 1 2 3 4 TargetArray 0 1 2 2 1
⎕←1 2 3 4 0 TargetArray 0 1 2 3 0
⎕←(,1)      TargetArray ,0
