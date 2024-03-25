MaxPositiveNegative←{⌈/+/1 ¯1∘.=×⍵}

⎕←MaxPositiveNegative ¯3 1 2 ¯1 3 ¯2 4
⎕←MaxPositiveNegative ¯1 ¯2 ¯3 1
⎕←MaxPositiveNegative 1 2
