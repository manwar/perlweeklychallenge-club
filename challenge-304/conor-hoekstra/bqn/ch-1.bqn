# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/304-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

CanArrangeBinary  ← { 𝕨≤+´⌊2÷˜+´¨fn.Group¬𝕩 } # Explicit
CanArrangeBinary2 ← ≤⟜(+´·⌊2÷˜+´¨∘fn.Group∘¬) # Tacit

# Tests
u.UnitTest (1 CanArrangeBinary  ⟨1, 0, 0, 0, 1⟩) ≡ 1
u.UnitTest (2 CanArrangeBinary  ⟨1, 0, 0, 0, 1⟩) ≡ 0
u.UnitTest (1 CanArrangeBinary2 ⟨1, 0, 0, 0, 1⟩) ≡ 1
u.UnitTest (2 CanArrangeBinary2 ⟨1, 0, 0, 0, 1⟩) ≡ 0
