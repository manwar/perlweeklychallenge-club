# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/332-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

OddLetters ← ∧´2|·≠¨·fn.Group∧

# Tests
u.UnitTest (OddLetters "weekly") ≡ 0
u.UnitTest (OddLetters "perl") ≡ 1
u.UnitTest (OddLetters "challenge") ≡ 0
