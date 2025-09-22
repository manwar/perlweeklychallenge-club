# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/340-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
s  ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

AscendingNumbers ← ∧´0<·fn.Deltas s.Nats

# Tests
u.UnitTest (AscendingNumbers "The cat has 3 kittens 7 toys 10 beds")      ≡ 1
u.UnitTest (AscendingNumbers "Alice bought 5 apples 2 oranges 9 bananas") ≡ 0
u.UnitTest (AscendingNumbers "I ran 1 mile 2 days 3 weeks 4 months")      ≡ 1
u.UnitTest (AscendingNumbers "Bob has 10 cars 10 bikes")                  ≡ 0
u.UnitTest (AscendingNumbers "Zero is 0 one is 1 two is 2")               ≡ 1
