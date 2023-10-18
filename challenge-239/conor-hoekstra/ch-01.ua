SameString ← ≅∩⊔∩/'⊂∩⊔

# Tests
SameString {"ab" "c"} {"ab" "c"}     # 1
SameString {"ab" "c"} {"ac" "b"}     # 0
SameString {"ab" "cd" "e"} {"abcde"} # 1
