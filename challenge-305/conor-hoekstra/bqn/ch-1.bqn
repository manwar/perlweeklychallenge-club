# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/305-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
p ⇐ •Import "/home/cph/bqn-code/lib/primes.bqn"
b ⇐ •Import "/home/cph/bqn-code/lib/binary.bqn"

BinaryPrefix ← p.IsPrime·b.Decimal¨∾`

# Tests
u.UnitTest (BinaryPrefix 1‿0‿1) ≡ 0‿1‿1
u.UnitTest (BinaryPrefix 1‿1‿0) ≡ 0‿1‿0
