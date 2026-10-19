Asc     ← >⊃⊢⊣
Same    ← =⊃⊢⊣
ZeroOne ← /+≡(≍ [0 1])
OneZero ← /+≡(≍ [1 0])

TrionicArray ← =₂++⊃(ZeroOne)(OneZero)⧈∘2⊃(≡Asc)(/+≡Same)⧈∘2

˙⍤ =₁ TrionicArray [1 3 5 4 2 6 8]
˙⍤ =₀ TrionicArray [1 4 4 2 1 3 5]
˙⍤ =₁ TrionicArray [2 10 3 1 9]
˙⍤ =₀TrionicArray [1 2 3 4 3 2 1]
˙⍤ =₀ TrionicArray [1 3 6 4 2 7 8 4]
