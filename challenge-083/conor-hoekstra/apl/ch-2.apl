 flipArray ← {
    m ← ⍉2(⊥⍣¯1)⍳¯1+2*≢⍵ ⍝ mask
    s ← +/x(×⍤1)1-2×m    ⍝ sums
    ⌊/(+/m)/⍨s=⌊/s/⍨0≤s
 }

⍝ Tests
flipArray 2 10 12 ⍝ 1
flipArray 3 10 8  ⍝ 1
