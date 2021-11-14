distinctTermCount ← {
   ⎕ ← t ← ⍺(∘.×⍥⍳)⍵
   ⎕ ← 'Distinct Terms:',∪,t
   ⎕ ← 'Count:',≢∪,t
}

⍝ Tests
      3 distinctTermCount 3
1 2 3
2 4 6
3 6 9
Distinct Terms: 1 2 3 4 6 9
Count: 6
      
      3 distinctTermCount 5 
1 2 3  4  5
2 4 6  8 10
3 6 9 12 15
Distinct Terms: 1 2 3 4 5 6 8 10 9 12 15
Count: 11
