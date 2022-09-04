# WEEK 15

# Challenge 2
#  Write a script to implement Vigenère cipher
#  The script should be able encode and decode
_Vigenere←{𝕨 (('a'+26|⊢𝔽⥊˜⟜≠)○('a'-˜+⟜(32×1="A["⊸⍋))) 𝕩}
Encd←({+} _Vigenere)
Decd←({-} _Vigenere)

"attackatdawn"≡"LEMON"Decd"LEMON"Encd"attackatdawn"
