#/usr/bin/env bqn

DigitSum ← { (10|𝕩) + (0⊸<)◶ 0‿𝕊 𝕩(⌊∘÷)10 }
ElementDigitSum ← +´-(+´ DigitSum¨)

•Show ElementDigitSum 1‿2‿3‿45
•Show ElementDigitSum 1‿12‿3
•Show ElementDigitSum 1‿2‿3‿4
•Show ElementDigitSum 236‿416‿336‿350
