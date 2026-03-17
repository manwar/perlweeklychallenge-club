⍝ https://arraybox.dev/#H7ln

Ds   ← +/⍎¨⍤⍕ ⍝ Digit sum
Aids ← { Ds⍣≡⊃,/⍕¨(⎕c⎕a)⍳⍵ }

Aids 'abc'  ⍝ 6
Aids 'az'   ⍝ 9
Aids 'cat'  ⍝ 6
Aids 'dog'  ⍝ 8
Aids 'perl' ⍝ 6
