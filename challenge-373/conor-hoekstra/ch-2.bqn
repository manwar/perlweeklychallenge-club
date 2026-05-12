# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/373-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

ListDivision ← { 
  a ← ⌊𝕨÷˜n←≠𝕩 
  b ← n-𝕨×a
  c ← ∾((b>↕𝕨)+𝕨⥊a)⥊¨↕𝕨
  c⊔𝕩
}

# Tests
u.UnitTest (2 ListDivision (1‿2‿3‿4‿5)) ≡ ⟨1‿2‿3⟩‿⟨4‿5⟩
u.UnitTest (3 ListDivision (1‿2‿3‿4‿5‿6)) ≡ (⟨1‿2⟩‿⟨3‿4⟩‿⟨5‿6⟩)   
u.UnitTest (2 ListDivision (1‿2‿3)) ≡ (⟨1‿2⟩‿⟨3⟩)
u.UnitTest (5 ListDivision (1‿2‿3‿4‿5‿6‿7‿8‿9‿10)) ≡ (⟨1‿2⟩‿⟨3‿4⟩‿⟨5‿6⟩‿⟨7‿8⟩‿⟨9‿10⟩)
u.UnitTest (4 ListDivision (1‿2‿3)) ≡ -1
u.UnitTest (7 ListDivision (72‿57‿89‿55‿36‿84‿10‿95‿99‿35)) ≡ (⟨72‿57⟩‿⟨89‿55⟩‿⟨36‿84⟩‿⟨10⟩‿⟨95⟩‿⟨99⟩‿⟨35⟩)
