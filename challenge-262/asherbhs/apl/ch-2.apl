⎕IO←0

CountEqualDivisible←{+/,(∘.=⍨⍵)∧(∘.(0=⍺|×)∧∘.<)⍨⍳≢⍵}

⎕←2 CountEqualDivisible 3 1 2 2 2 1 3
⎕←1 CountEqualDivisible 1 2 3
