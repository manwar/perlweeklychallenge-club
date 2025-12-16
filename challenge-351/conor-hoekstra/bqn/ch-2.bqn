# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/351-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

ArithmeticProgression ← (1=≠∘⍷)·fn.Deltas∧

# Tests
u.UnitTest (ArithmeticProgression ⟨1, 3, 5, 7, 9⟩) ≡ 1
u.UnitTest (ArithmeticProgression ⟨9, 1, 7, 5, 3⟩) ≡ 1
u.UnitTest (ArithmeticProgression ⟨1, 2, 4, 8, 16⟩) ≡ 0
u.UnitTest (ArithmeticProgression ⟨5, -1, 3, 1, -3⟩) ≡ 1
u.UnitTest (ArithmeticProgression ⟨1.5, 3, 0, 4.5, 6⟩) ≡ 1
