# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/309-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

MinGap  ← { ⊑𝕩⊏˜1+/⌊´⊸=fn.Deltas𝕩 } # Explicit
MinGap2 ← ⊑(1+·/·⌊´⊸=fn.Deltas)⊸⊏   # Tacit

# Tests
u.UnitTest (MinGap  ⟨2, 8, 10, 11, 15⟩) ≡ 11
u.UnitTest (MinGap  ⟨1, 5, 6, 7, 14⟩)   ≡ 6
u.UnitTest (MinGap  ⟨8, 20, 25, 28⟩)    ≡ 28
u.UnitTest (MinGap2 ⟨2, 8, 10, 11, 15⟩) ≡ 11
u.UnitTest (MinGap2 ⟨1, 5, 6, 7, 14⟩)   ≡ 6
u.UnitTest (MinGap2 ⟨8, 20, 25, 28⟩)    ≡ 28