ConsistentStrings ← /+∺(/↧∊∶⊙⊔)

# Tests
ConsistentStrings "ab" {"ad" "bd" "aaab" "baa" "badab"}            # 2
ConsistentStrings "abc" {"a" "b" "c" "ab" "ac" "bc" "abc"}         # 7
ConsistentStrings "cad" {"cc" "acd" "b" "ba" "bac" "bad" "ac" "d"} # 4
