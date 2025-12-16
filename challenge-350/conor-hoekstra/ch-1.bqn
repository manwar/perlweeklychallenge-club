# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/350-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

GoodSubstrings ← +´·(3=≠∘⍷)˘3↕⊢

# Tests
u.UnitTest (GoodSubstrings "abcaefg") ≡ 5
u.UnitTest (GoodSubstrings "xyzzabc") ≡ 3
u.UnitTest (GoodSubstrings "aababc") ≡ 1
u.UnitTest (GoodSubstrings "qwerty") ≡ 4
u.UnitTest (GoodSubstrings "zzzaaa") ≡ 0
