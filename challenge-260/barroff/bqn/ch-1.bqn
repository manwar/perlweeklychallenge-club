#/usr/bin/env bqn

ints ← 2‿5‿9‿11‿3

UniqueOccurrences ← ∧´∘∊(+´˘(∊/⊢)=⌜⊢)

•Show UniqueOccurrences ⟨1,2,2,1,1,3⟩
•Show UniqueOccurrences ⟨1,2,3⟩
•Show UniqueOccurrences ⟨-2,0,1,-2,1,1,0,1,-2,9⟩
