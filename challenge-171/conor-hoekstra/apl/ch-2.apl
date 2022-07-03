    compose ← {⍺⍺ ⍵⍵ ⍵}

    ⍝ Multiply by 2, then add 1
    {1+⍵} compose {2×⍵} 10
21
    ⍝ Reverse then drop 1
    1∘↓ compose ⌽ ⍳5
4 3 2 1
