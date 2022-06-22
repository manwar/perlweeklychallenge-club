    ⍝ Solution using dfns.pco
    )load dfns
    ×\1, pco ⍳10
1 2 6 30 210 2310 30030 510510 9699690 223092870 6469693230

    ⍝ Solution not using dfns.pco
    isPrime ← 2≥(≢∘∪⍳∨⊢)
    ×\(isPrime¨⊢⍤/⊢) ⍳25
1 2 6 30 210 2310 30030 510510 9699690 223092870
