# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/321-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

DistinctAverage  ← { ≠⍷+˝⌽⌾⊏2‿∘⥊∧𝕩 } # Explicit
DistinctAverage2 ← ≠·⍷·+˝·⌽⌾⊏2‿∘⥊∧   # Tacit

# Tests
u.UnitTest (DistinctAverage  ⟨1, 2, 4, 3, 5, 6⟩) ≡ 1
u.UnitTest (DistinctAverage  ⟨0, 2, 4, 8, 3, 5⟩) ≡ 2
u.UnitTest (DistinctAverage  ⟨7, 3, 1, 0, 5, 9⟩) ≡ 2
u.UnitTest (DistinctAverage2 ⟨1, 2, 4, 3, 5, 6⟩) ≡ 1
u.UnitTest (DistinctAverage2 ⟨0, 2, 4, 8, 3, 5⟩) ≡ 2
u.UnitTest (DistinctAverage2 ⟨7, 3, 1, 0, 5, 9⟩) ≡ 2
