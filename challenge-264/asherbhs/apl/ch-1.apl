GreatestEnglishLetter←{/⍨∘(⎕IO=⍒)⍨⊃∩/(≥⍥⎕UCS∘'a'(⊂1⎕C⊢)⌸⊢)⍵}

⎕←GreatestEnglishLetter 'PeRlwEeKLy'
⎕←GreatestEnglishLetter 'ChaLlenge'
⎕←GreatestEnglishLetter 'The'
