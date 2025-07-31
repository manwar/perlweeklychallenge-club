# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/323-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

IncrementDecrement ← +´·-˝"+-"=⌜⊑∘∧¨

# Tests
u.UnitTest (IncrementDecrement ⟨"--x", "x++", "x++"⟩)        ≡ 1
u.UnitTest (IncrementDecrement ⟨"x++", "++x", "x++"⟩)        ≡ 3
u.UnitTest (IncrementDecrement ⟨"x++", "++x", "--x", "x--"⟩) ≡ 0
