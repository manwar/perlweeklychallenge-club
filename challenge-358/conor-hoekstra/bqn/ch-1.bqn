# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/358-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

MaxStrValue ← ⌈´(s.IsDigit◶≠‿•BQN)¨

# Tests
u.UnitTest (MaxStrValue ⟨"123", "45", "6"⟩) ≡ 123
u.UnitTest (MaxStrValue ⟨"abc", "de", "fghi"⟩) ≡ 4
u.UnitTest (MaxStrValue ⟨"0012", "99", "a1b2c"⟩) ≡ 99
u.UnitTest (MaxStrValue ⟨"x", "10", "xyz", "007"⟩) ≡ 10
u.UnitTest (MaxStrValue ⟨"hello123", "2026", "perl"⟩) ≡ 2026