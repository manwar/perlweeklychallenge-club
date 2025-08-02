MaximumAverage ← { ⌈/⍺÷⍨⍺+/⍵ }

⍝ Tests
4 MaximumAverage 1 12 ¯5 ¯6 50 3 ⍝ 12.75
1 MaximumAverage 5               ⍝ 5
