# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/330-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

Bad ← { ∨´s.IsDigit¨𝕩 }
Fix ← { 𝕩/˜¬(↕≠𝕩)∊¯1‿0+⊑/s.IsDigit¨𝕩 }
ClearDigits ← { Fix•_while_ Bad 𝕩 }

# Tests
u.UnitTest (ClearDigits "cab12")  ≡ "c"
u.UnitTest (ClearDigits "xy99")   ≡ ""
u.UnitTest (ClearDigits "pa1erl") ≡ "perl"
