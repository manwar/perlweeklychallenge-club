#/usr/bin/env bqn

MaxPositiveNegative ← (+´0⊸<)⌈(+´0⊸>)

•Show MaxPositiveNegative ⟨-3, 1, 2, -1, 3, -2, 4⟩
•Show MaxPositiveNegative ⟨-1, -2, -3, 1⟩
•Show MaxPositiveNegative ⟨1, 2⟩
