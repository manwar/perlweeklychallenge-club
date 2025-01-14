CanArrangeBinary ← { ⍺≤+/⌊2÷⍨+/¨⊆⍨~⍵ }

⍝ Tests
1 CanArrangeBinary 1 0 0 0 1 ⍝ 1
2 CanArrangeBinary 1 0 0 0 1 ⍝ 2
