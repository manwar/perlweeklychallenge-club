# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/339-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

PeakPoint ← 0⌈´+`

# Tests
u.UnitTest (PeakPoint ⟨¯5, 1, 5, ¯9, 2⟩)    ≡ 1
u.UnitTest (PeakPoint ⟨10, 10, 10, ¯25⟩)    ≡ 30
u.UnitTest (PeakPoint ⟨3, -4, 2, 5, ¯6, 1⟩) ≡ 6
u.UnitTest (PeakPoint ⟨¯1, -2, -3, -4⟩)     ≡ 0
u.UnitTest (PeakPoint ⟨¯10, 15, 5⟩)         ≡ 10
