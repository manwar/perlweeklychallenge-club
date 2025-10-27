# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/345-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

PeakPositions ← { /¯2=fn.Deltas×fn.Deltas 0∾˜0∾𝕩 }

# Tests
u.UnitTest (PeakPositions ⟨1, 3, 2⟩)             ≡ ⟨1⟩
u.UnitTest (PeakPositions ⟨2, 4, 6, 5, 3⟩)       ≡ ⟨2⟩
u.UnitTest (PeakPositions ⟨1, 2, 3, 2, 4, 1⟩)    ≡ ⟨2, 4⟩
u.UnitTest (PeakPositions ⟨5, 3, 1⟩)             ≡ ⟨0⟩
u.UnitTest (PeakPositions ⟨1, 5, 1, 5, 1, 5, 1⟩) ≡ ⟨1, 3, 5⟩
