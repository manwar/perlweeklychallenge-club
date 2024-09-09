# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/285-1.bqn

DeadEnds ← ⊢´¨(¬∘∊/⊣)⊑¨
         # (↑¨↓¨)«~»(↑¨) - Kap (original)
         # ⊢/¨«~»(↑¨)    - Kap
         # ⊢/¨~⊃¨        - Dyalog APL
         # {⊃~/⌽↓⍉↑⍵}    - Dyalog APL (Alternative)
         # Ṫ€ḟḢ€         - Jelly
         # ↓¨~↑¨         - Hypothetical APL

# Tests
•Show DeadEnds ⟨⟨"B","C"⟩, ⟨"D","B"⟩, ⟨"C","A"⟩⟩ # "A"
•Show DeadEnds ⟨⟨"A","Z"⟩⟩                       # "Z"
