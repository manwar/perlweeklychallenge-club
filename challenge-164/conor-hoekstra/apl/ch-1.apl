isPalindrome ← (⌽≡⊢)⍕
isPrime ← {2≥≢∪⍵∨⍳⍵}
      
primePalindromes ← ((isPalindrome∧isPrime)¨⊢⍤/⊢)⍳1000
      
⍝ Display results
3 7⍴primePalindromes

  1   2   3   5   7  11 101
131 151 181 191 313 353 373
383 727 757 787 797 919 929
