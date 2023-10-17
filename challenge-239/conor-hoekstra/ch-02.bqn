ConsistentStrings ← {+´∧´¨∊⟜𝕨¨𝕩} # Explicit
ConsistentStrings ← +´·∧´¨⊢∊¨<∘⊣ # Tacit

# Tests
 "ab" ConsistentStrings "ad"‿"bd"‿"aaab"‿"baa"‿"badab"           # 2
"abc" ConsistentStrings "a"‿"b"‿"c"‿"ab"‿"ac"‿"bc"‿"abc"         # 7
"cad" ConsistentStrings "cc"‿"acd"‿"b"‿"ba"‿"bac"‿"bad"‿"ac"‿"d" # 4
