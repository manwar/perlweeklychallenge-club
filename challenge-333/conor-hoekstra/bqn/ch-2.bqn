# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/333-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

DuplicateZeros  ← { (≠𝕩)↑𝕩/˜1+0=𝕩 } # Explicit
DuplicateZeros2 ← ≠↑(1+0=⊢)⊸/       # Tacit

# Tests
u.UnitTest (DuplicateZeros  ⟨1, 0, 2, 3, 0, 4, 5, 0⟩) ≡ ⟨1, 0, 0, 2, 3, 0, 0, 4⟩
u.UnitTest (DuplicateZeros  ⟨1, 2, 3⟩)                ≡ ⟨1, 2, 3⟩
u.UnitTest (DuplicateZeros  ⟨1, 2, 3, 0⟩)             ≡ ⟨1, 2, 3, 0⟩
u.UnitTest (DuplicateZeros  ⟨0, 0, 1, 2⟩)             ≡ ⟨0, 0, 0, 0⟩
u.UnitTest (DuplicateZeros  ⟨1, 2, 0, 3, 4⟩)          ≡ ⟨1, 2, 0, 0, 3⟩
u.UnitTest (DuplicateZeros2 ⟨1, 0, 2, 3, 0, 4, 5, 0⟩) ≡ ⟨1, 0, 0, 2, 3, 0, 0, 4⟩
u.UnitTest (DuplicateZeros2 ⟨1, 2, 3⟩)                ≡ ⟨1, 2, 3⟩
u.UnitTest (DuplicateZeros2 ⟨1, 2, 3, 0⟩)             ≡ ⟨1, 2, 3, 0⟩
u.UnitTest (DuplicateZeros2 ⟨0, 0, 1, 2⟩)             ≡ ⟨0, 0, 0, 0⟩
u.UnitTest (DuplicateZeros2 ⟨1, 2, 0, 3, 4⟩)          ≡ ⟨1, 2, 0, 0, 3⟩
