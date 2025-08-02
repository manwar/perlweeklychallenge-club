Diffs ← [[1 2] [2 1]
         [1 ¯2] [2 ¯1]
         [¯1 2] [¯2 1]
         [¯1 ¯2] [¯2 ¯1]]
Convert ← ⍜°⊂(⊓-⋕-1@a)
IsValid ← ×⊓>≤0,8
FilterMoves ← ▽≡/×IsValid.
ApplyDiffs ← +Diffs¤

# ? end start
KnightsMove ← ◌◌⍢(⊙⊙(+1)◴FilterMoves☇1≡ApplyDiffs|=0/+∊:,,)⊙⊙(0)¤:∩Convert
KnightsMove "a8" "g2"
KnightsMove "h2" "g2"

