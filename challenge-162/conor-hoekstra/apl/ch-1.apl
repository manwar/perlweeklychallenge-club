checkDigit ← {10-10|+/(⊢×1 3⍴⍨≢)⍎¨¯1↓⍵~'-'}

⍝ Test
checkDigit '978-0-306-40615-7' ⍝ 7
checkDigit '978-1-861-97271-2' ⍝ 2
