# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/329-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

CountIntegers ← ⍷s.Nats

# Tests
u.UnitTest (CountIntegers "the1weekly2challenge2") ≡ ⟨1, 2⟩
u.UnitTest (CountIntegers "go21od1lu5c7k") ≡ ⟨21, 1, 5, 7⟩
u.UnitTest (CountIntegers "4p3e2r1l") ≡ ⟨4, 3, 2, 1⟩
