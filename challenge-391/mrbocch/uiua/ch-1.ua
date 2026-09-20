OddLength ← ˙⍤ =₁ ◿₂⧻

Avg ← ÷⊃⧻(/+)

# assuming sorted list
Median ← ⍣(
  ⍩(⊏⌊÷₂⊸⧻) ⊸OddLength
| Avg⊏⊂⊸-₁÷₂⊸⧻
)

ArrayMedian ← Median⍆⊂

˙⍤ =₃ ArrayMedian [2] [4]
˙⍤ =₇ ArrayMedian [1 2 3] [7 8 9 10]
˙⍤ =₂₅ArrayMedian [] [10 20 30 40]
˙⍤ = 4.5 ArrayMedian [100] [1 2 3 4 5 6 7]
˙⍤ =₂ArrayMedian [1 2 2] [2 2 3]
