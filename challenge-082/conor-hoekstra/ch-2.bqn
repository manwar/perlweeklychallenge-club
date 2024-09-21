# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/082-2.bqn

Interleave    ← { n𝕊a‿b: n(↑(∾⟜b⊸∾)↓)a }
IsInterleaved ← { ∨´𝕨⊸≡¨(↕≠⊑𝕩)Interleave¨<𝕩 }

# Tests
•Show    "XXY" IsInterleaved "XY"‿"X"    # 1
•Show "XXXXZY" IsInterleaved "XXY"‿"XXZ" # 1
•Show    "XXY" IsInterleaved "YX"‿"X"    # 0
