# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/357-1.bqn

ZPad     ← ˜⊂⊸(♭˜↯"0"˜-4⧻)
KIter    ← -∩⋕⊃⍆(⇌⍆)ZPad°⋕
Kaprekar ← ⊢˜⊂¯1⊚=6174\˜(KIter⋅)↯8

# Tests
⍤⟜≍ 3 Kaprekar 3524  
⍤⟜≍ 0 Kaprekar 6174  
⍤⟜≍ 5 Kaprekar 9998  
⍤⟜≍ 4 Kaprekar 1001  
⍤⟜≍ 4 Kaprekar 9000 
⍤⟜≍ ¯1 Kaprekar 1111
