min ← ⌊/
avg ← +/÷≢
max ← ⌈/

percentile ← {
   i ← 100÷⍨⍺×¯1+≢⍵ ⍝ index
   avg ⍵[1+(⌈,⌊)i]
}

fiveNumSummary ← min,25∘percentile,avg,75∘percentile,max

⍝ Tests
      fiveNumSummary 0 0 1 2 63 61 27 13
0 0.5 20.875 44 63
      fiveNumSummary ⍳5
1 2 3 4 5
