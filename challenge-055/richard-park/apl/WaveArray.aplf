 WaveArray←{
⍝ Thanks to Total Array Ordering, an array ⍵ can be reordered so that its major cells, m, have the property
⍝ (1⌷⍵)≥(2⌷⍵)≤(3⌷⍵)≥(4⌷⍵)≤...
⍝ ⍵: Array
⍝ ←: Array of rank (1+≢⍴⍵) where each major cell is a wave permutation of ⍵
     n←≢⍵
     p←⍵⌷⍤0 99⍨Pmat n        ⍝ Permutations of ⍵
     gte←(¯1+n)⍴1 0          ⍝ Wave-array greater-than or equal pattern
     lte←~gte                ⍝ Wave-array less-than or equal pattern
     g←gte≡⍤1⊢2≥/(⍋⍋)⍤¯1⊢p   ⍝ Permutations with wave gte pattern
     l←lte≡⍤1⊢2≤/(⍋⍋)⍤¯1⊢p   ⍝ Permutations with wave lte pattern
     ∪(g∧l)⌿p                ⍝ Unique wave permutations of ⍵
 }
