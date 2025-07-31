# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/329-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
s  ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

IsNice ← { l ← ∧⍷𝕩 ⋄ n ← ⌈2÷˜≠l ⋄ (l↑˜-n)≡s.Lower n↑l }
NiceString ← { ⊑(⌈´⊸=≠¨)⊸/IsNice¨⊸/⍷fn.PowerSet𝕩 }

# Tests
u.UnitTest (NiceString "YaaAho") ≡ "aaA"
u.UnitTest (NiceString "cC") ≡ "cC"
u.UnitTest (NiceString "A") ≡ ""
