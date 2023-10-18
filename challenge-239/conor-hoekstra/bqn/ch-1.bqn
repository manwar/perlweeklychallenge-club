SameString ← ≡○(∾´)

# Tests
     "a"‿"bc" SameString "ab"‿"c" # 1
     "ab"‿"c" SameString "ac"‿"b" # 0
"ab"‿"cd"‿"e" SameString "abcde"  # 1
