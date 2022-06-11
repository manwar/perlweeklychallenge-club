fibDigitSum ← {
    ⎕IO  ← 0
    fibs ← (⍳+.!⌽∘⍳)¨⍳⍵
    ⍵↑⍸fibs∊⍨{+/⍎¨⍕⍵}¨⍳10×⍵
}

⍝ Test
fibDigitSum 20 

⍝ Output
0 1 2 3 5 8 10 11 12 14 17 20 21 23 26 30 32 35 41 44
