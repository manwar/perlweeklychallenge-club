⎕IO←1

ReverseDegree←(⍳≢)+.×(⌽⎕C⎕A)⍳⊢

⎕←ReverseDegree 'z'
⎕←ReverseDegree 'a'
⎕←ReverseDegree 'bbc'
⎕←ReverseDegree 'racecar'
⎕←ReverseDegree 'zyx'
