# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/380-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Rd ← +´(1+↕∘≠)×'{'⊸-

# Tests
u.UnitTest (Rd "z") ≡ 1
u.UnitTest (Rd "a") ≡ 26
u.UnitTest (Rd "bbc") ≡ 147
u.UnitTest (Rd "racecar") ≡ 560
u.UnitTest (Rd "zyx") ≡ 14
