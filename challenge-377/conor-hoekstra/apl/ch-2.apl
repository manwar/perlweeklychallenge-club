⍝ https://arraybox.dev/#YPTR

P  ← ⊃⍤⍷
H  ← { h ← ⊃⍵ ⋄ t ← 1↓⍵ ⋄+/(⌽¨(⌽h)∘P¨⌽¨t)∧h∘P¨t }
Ps ← { +/H¨⌽∘⍵¨⍳≢⍵ }
