middleThreeDigits ← {
   s ← ⍕|⍵
   0=2|≢s : 'Even # of digits' ⋄
   3>≢s   : 'Too short'        ⋄
   (3↑(2÷⍨¯3+≢)↓⊢)s
}

⍝ Tests
middleThreeDigits 1234567 ⍝ 345
middleThreeDigits ¯123    ⍝ 123
middleThreeDigits 1       ⍝ Too short
middleThreeDigits 10      ⍝ Even # of digits
