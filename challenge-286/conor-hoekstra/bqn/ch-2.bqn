# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/286-2.bqn

OrderGame ← { 1=≠𝕩 ? ⊑𝕩 ; 𝕊 •Show ((2÷˜≠𝕩)⥊⟨⌊´,⌈´⟩) {𝕎𝕩}¨ <˘∘‿2⥊𝕩 }

# Tests
# Example 1
•Show OrderGame ⟨2, 1, 4, 5, 6, 3, 0, 2⟩                         # 1
•Show OrderGame ⟨0, 5, 3, 2⟩                                     # 0
•Show OrderGame ⟨9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8⟩ # 2
