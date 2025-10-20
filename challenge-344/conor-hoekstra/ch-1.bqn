# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/344-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
b ⇐ •Import "/home/cph/bqn-code/lib/binary.bqn"

FromDigits ← { +´𝕩×⌽10⋆↕≠𝕩 }
ArrayFormCompute ← b.Digits+⟜FromDigits

# Tests
u.UnitTest (  12 ArrayFormCompute ⟨1, 2, 3, 4⟩)    ≡ ⟨1, 2, 4, 6⟩
u.UnitTest ( 181 ArrayFormCompute ⟨2, 7, 4⟩)       ≡ ⟨4, 5, 5⟩
u.UnitTest (   1 ArrayFormCompute ⟨9, 9, 9⟩)       ≡ ⟨1, 0, 0, 0⟩
u.UnitTest (9999 ArrayFormCompute ⟨1, 0, 0, 0, 0⟩) ≡ ⟨1, 9, 9, 9, 9⟩
u.UnitTest (1000 ArrayFormCompute ⟨0⟩)             ≡ ⟨1, 0, 0, 0⟩
