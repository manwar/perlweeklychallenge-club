⎕IO←0

TwiceLargest←{¯1⊣⍣((¯1+≢⍵)≠m+.≥2×⍵)⊢⍵⍳m←⌈/⍵}

⎕←TwiceLargest 2 4 1 0
⎕←TwiceLargest 1 2 3 4
