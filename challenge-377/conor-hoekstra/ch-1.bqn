# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/377-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

ReverseExistence ← { ∨´∨´˘⍷⟜(⌽𝕩)˘2↕𝕩 }

# Tests
u.UnitTest (ReverseExistence "abcba") ≡ 1
u.UnitTest (ReverseExistence "racecar") ≡ 1
u.UnitTest (ReverseExistence "abcd") ≡ 0
u.UnitTest (ReverseExistence "banana") ≡ 1
u.UnitTest (ReverseExistence "hello") ≡ 1
