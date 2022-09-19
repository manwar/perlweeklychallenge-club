      d ← ⊃⎕NGET '/home/cph/perlweeklychallenge-club/data/dictionary.txt' 1 
      
      FROM ← 'olistabcdef'
      TO   ← '01157abcdef'
      
      hexWord ← {((2∘≤∧8∘≥)≢⍵)∧∧/⍵∊FROM}
      toHex   ← {TO[FROM⍳⍵]}

      ⍝ Number of "hex words"
      ≢(hexWord¨⊢⍤/⊢) d
1463

      ⍝ First 36 "hex words"
      6 6⍴36↑toHex¨(hexWord¨⊢⍤/⊢) d
┌────────┬───────┬────────┬────────┬────────┬────────┐
│aba7e   │aba7ed │aba7e5  │abb07   │abb075  │abd1ca7e│
├────────┼───────┼────────┼────────┼────────┼────────┤
│abe7    │abe75  │abe77ed │ab1de   │ab1de5  │ab1e    │
├────────┼───────┼────────┼────────┼────────┼────────┤
│ab1e57  │ab0de  │ab0de5  │ab5ce55 │accede  │acceded │
├────────┼───────┼────────┼────────┼────────┼────────┤
│accede5 │acce55 │acce55ed│acce55e5│acc01ade│acc057  │
├────────┼───────┼────────┼────────┼────────┼────────┤
│acc057ed│acc0575│ace     │aced    │ace5    │ac1d    │
├────────┼───────┼────────┼────────┼────────┼────────┤
│ac1d5   │ac7    │ac7ed   │ac75    │ad      │add     │
└────────┴───────┴────────┴────────┴────────┴────────┘
