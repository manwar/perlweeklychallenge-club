splitNumber ← {
    n ← ≢⍕⍵                   ⍝ # of digits
    m ← 2(⊥⍣¯1)(¯1∘++⍳)2*¯1+n ⍝ masks
    p ← (↓⍉m)⊂¨⊂⍕⍵            ⍝ partitions
    ∨/(⍵*0.5)={+/⍎¨⍵}¨p
}

splitNumber ¨ 81 9801 36 ⍝ 1 1 0
