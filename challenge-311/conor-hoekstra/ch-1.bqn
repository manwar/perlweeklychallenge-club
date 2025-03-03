# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/311-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

UpperLower ← { a‿b ← ⥊¨⌽⊸⋈"aA"+⌜↕26 ⋄ a⊏˜b⊐𝕩 }

# Tests
u.UnitTest (UpperLower "pERl")   ≡ "PerL"
u.UnitTest (UpperLower "rakU")   ≡ "RAKu"
u.UnitTest (UpperLower "PyThOn") ≡ "pYtHoN"
