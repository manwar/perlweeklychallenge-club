# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/325-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Price      ← ⊑·0⊸≤⊸/⊑(-∾⊣)1⊸↓
FinalPrice ← Price¨¯1↓↓

# Tests
u.UnitTest (FinalPrice 8‿4‿6‿2‿3) ≡ 4‿2‿4‿2‿3
u.UnitTest (FinalPrice 1‿2‿3‿4‿5) ≡ 1‿2‿3‿4‿5
u.UnitTest (FinalPrice 7‿1‿1‿5)   ≡ 6‿0‿1‿5
