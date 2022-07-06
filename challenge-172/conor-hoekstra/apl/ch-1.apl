)load dfns

primePartitions ← {
   p ← ⍸1 pco ⍳⍵    ⍝ primes
   c ← p[⍺ cmat ≢p] ⍝ combiations
   (↓c)/⍨⍵=+/c
}

⍝ Tests
      2 primePartitions 18 
┌────┬────┐
│5 13│7 11│
└────┴────┘
      3 primePartitions 19
┌──────┐
│3 5 11│
└──────┘