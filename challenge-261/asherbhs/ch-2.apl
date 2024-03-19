MultiplyByTwo←{⍵∊⍺: ⍺∇2×⍵ ⋄ ⍵}
⎕←5 3 6 1 12 MultiplyByTwo 3
⎕←1 2 4 3    MultiplyByTwo 1
⎕←5 6 7      MultiplyByTwo 2
