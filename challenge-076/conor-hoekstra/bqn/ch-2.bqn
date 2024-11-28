# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/076-2.bqn

⟨UnitTest⟩ ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

# Constants
file ← "/home/cph/bqn-code/pwc/076-search-grid.txt"
dict ← "/home/cph/scrabble/scrabble/dictionary/nwl_2020.txt"

FindWords ← {
    d  ← (5≤≠¨)⊸/⊑∘s.Words¨•file.Lines dict # dictionary
    l  ← >' '⊸≠⊸/¨•file.Lines 𝕩             # lines
    Cs ← {(1<≠¨)⊸/∾∾(↑¨↓)¨𝕩}                # contiguous substrings
    Ad ← (+⌜´↕¨∘≢)⊸⊔                        # anti-diagonals
    d/˜d∊⍷Cs∾{𝕎𝕩}⟜l¨⟨Ad·⍉⌽,Ad⍉,Ad⌽,Ad,<˘⍉,<˘⌽˘,<˘⌽⟩
}

# Test
expected ← s.Upper¨ ", " s.Split "aimed, align, antes, arose, ashed, blunt, blunts, broad, buries, clove, cloven, constitution, constitutions, croon, depart, departed, enter, filch, garlic, goats, grieve, grieves, hazard, liens, malign, malignant, malls, midst, ought, ovary, parted, pudgiest, quash, quashed, ruses, shrine, shrines, social, socializing, spasm, spasmodic, succor, succors, theorem, theorems, virus, viruses, wigged"

UnitTest ((res ← FindWords file) (¬∘∊⊸/⊣) expected) ≡ ⟨⟩
