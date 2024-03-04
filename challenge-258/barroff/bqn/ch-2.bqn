#/usr/bin/env bqn

ints ← 2‿5‿9‿11‿3

DecToBin ← { (((0⊸<)◶""‿𝕊∘⌊2⊸(÷˜))∾(•Fmt 2⊸|)) 𝕩 }

SumOfValues ← { +´𝕩×𝕨=+´¨('0'⊸(-˜)¨)¨DecToBin¨↕≠𝕩 }

•Show 1 SumOfValues ints
•Show 2 SumOfValues ints
•Show 0 SumOfValues ints
