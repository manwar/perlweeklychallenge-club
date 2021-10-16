⍝ Solution 1
pandigital ← +/¯1,((⊢*-∘2)×-∘1),((*⍨-⊢)÷(2*⍨1-⍨⊢)) 

1,pandigital¨1+⍳4 ⍝ 1 2 11 75 694

⍝ Solution 2
pandigital ← {
   a ← (*⍨-⊢)⍵  ⍝ ⍵^⍵ - ⍵
   b ← ⍵-1      ⍝ ⍵-1
   c ← (⊢*-∘2)⍵ ⍝ ⍵^(⍵-2)
   (a÷b*2)+(b×c)-1
}

1,pandigital¨1+⍳4 ⍝ 1 2 11 75 694

⍝ Solution 3
pandigital ← {(⍺=≢∘∪)⍺(⊥⍣¯1)⍵}
      
1,{ ⊃⍸⍵∘pandigital¨⍳1000 }¨1+⍳4 ⍝ 1 2 11 75 694
