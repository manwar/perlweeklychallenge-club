# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/317-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

FriendlyStrings  ← { ((∧𝕨)≡∧𝕩)∧2=+´𝕨≠𝕩 } # Explicit
FriendlyStrings2 ← ≡○∧∧(2=·+´≠)          # Implicit

# Tests
u.UnitTest (  "dsec" FriendlyStrings  "desc")   ≡ 1
u.UnitTest (  "fcuk" FriendlyStrings  "fuck")   ≡ 1
u.UnitTest (   "eop" FriendlyStrings  "poo")    ≡ 0
u.UnitTest ("sprite" FriendlyStrings  "stripe") ≡ 1
u.UnitTest (  "dsec" FriendlyStrings2 "desc")   ≡ 1
u.UnitTest (  "fcuk" FriendlyStrings2 "fuck")   ≡ 1
u.UnitTest (   "eop" FriendlyStrings2 "poo")    ≡ 0
u.UnitTest ("sprite" FriendlyStrings2 "stripe") ≡ 1
