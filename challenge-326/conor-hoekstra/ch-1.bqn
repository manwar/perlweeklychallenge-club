# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/326-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

days ← 31‿28‿31‿30‿31‿30‿31‿31‿30‿31‿30‿31
DayOfYear ← {
    m‿d ← •BQN¨1↓'-'⊸s.Split𝕩
    d++´days↑˜m-1
}

# Tests
u.UnitTest (DayOfYear "2025-02-02") ≡ 33
u.UnitTest (DayOfYear "2025-04-10") ≡ 100
u.UnitTest (DayOfYear "2025-09-07") ≡ 250
