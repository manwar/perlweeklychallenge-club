#/usr/bin/env bqn

DigitSum ← { (10|𝕩) + (0⊸<)◶ 0‿𝕊 𝕩(⌊∘÷)10 }
SumDifference ← +´-(+´ DigitSum¨)

•Show SumDifference 1‿23‿4‿5
•Show SumDifference 1‿2‿3‿4‿5
•Show SumDifference 1‿2‿34
•Show SumDifference 236‿416‿336‿350
