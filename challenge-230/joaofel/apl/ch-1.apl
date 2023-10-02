    sepDigits ← ,/((⍴∘10(1+(⌊(10∘⍟⊢))))⊤⊢)¨
    sepDigits 1 34 5 6 ⍝ 1 3 4 5 6
    sepDigits 1 24 51 60 ⍝ 1 2 4 5 1 6 0
