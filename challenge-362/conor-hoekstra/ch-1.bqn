# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/362-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

EchoChamber ← ⊢/˜1+↕∘≠

# Tests
u.UnitTest (EchoChamber "abca")  ≡ "abbcccaaaa"
u.UnitTest (EchoChamber "xyz")   ≡ "xyyzzz"
u.UnitTest (EchoChamber "hello") ≡ "heelllllllooooo"
u.UnitTest (EchoChamber "a")     ≡ "a"
