# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/320-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
b ⇐ •Import "/home/cph/bqn-code/lib/binary.bqn"

SumDifference ← |(+´·∾b.Digits¨)-+´

# Tests
u.UnitTest (SumDifference (1‿23‿4‿5))  ≡ 18
u.UnitTest (SumDifference (1‿2‿3‿4‿5)) ≡ 0
u.UnitTest (SumDifference (1‿2‿34))    ≡ 27
