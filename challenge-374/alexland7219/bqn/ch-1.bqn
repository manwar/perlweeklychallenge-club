# Task 1

IsOK ← "aeiou"⊸≡∧∘⍷
CountVowels ← IsOK¨⊸/·⟨⟩⊸≢¨⊸/·∾´↓¨∘↑

! ⟨⟩≡·CountVowels "aeioaeioa"

! ⟨"uaeio", "uaeiou", "aeiou"⟩≡·CountVowels "uaeiou"

! ⟨"aeiou", "aeiouu", "aeiouua", 
   "eiouua", "aeiou"⟩≡·CountVowels "aeiouuaxaeiou"

! ⟨"aaeeeiioou", "aeeeiioou", "aaeeeiioouu",
   "aeeeiioouu" ⟩≡·CountVowels "aaeeeiioouu"

! ⟨"aeiou"⟩ ≡·CountVowels "aeiou"