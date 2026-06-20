⍝ https://arraybox.dev/#iYtW

⍝ Original
Re ← { ∨/∨/¨⍷∘(⌽⍵)¨2,/⍵ } ⍝ Explicit
Re ← ∨/(∨/¨(2,/⊢)⍷¨⊂∘⌽)   ⍝ Tacit

⍝ Improved after ArrayCast Episode 126
⍝ Link: https://www.youtube.com/watch?v=rPXx-sH2fRQ
Re ← { ∨/⌽¨⍛∊2,/⍵ } ⍝ Explicit
Re ← ∨/(⌽¨⍛∊2,/⊢)   ⍝ Tacit
