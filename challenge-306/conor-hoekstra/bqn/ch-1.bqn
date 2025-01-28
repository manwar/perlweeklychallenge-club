# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/306-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

OddSum  ← { +´∾⥊¨(1+2×↕⌈2÷˜≠𝕩)↕¨<𝕩 } # Explicit
OddSum2 ← +´·∾·⥊¨((1+2×↕)·⌈2÷˜≠)↕¨<  # Tacit

# Tests
u.UnitTest (OddSum  ⟨2,5,3,6,4⟩) ≡ 77
u.UnitTest (OddSum  ⟨1,3⟩)       ≡ 4
u.UnitTest (OddSum2 ⟨2,5,3,6,4⟩) ≡ 77
u.UnitTest (OddSum2 ⟨1,3⟩)       ≡ 4
