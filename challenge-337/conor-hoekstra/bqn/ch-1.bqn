# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/337-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

SmallerThanCurrent ← ¯1+·+´˘≥⌜˜

# Tests
u.UnitTest (SmallerThanCurrent ⟨6, 5, 4, 8⟩)      ≡ ⟨2, 1, 0, 3⟩
u.UnitTest (SmallerThanCurrent ⟨7, 7, 7, 7⟩)      ≡ ⟨3, 3, 3, 3⟩
u.UnitTest (SmallerThanCurrent ⟨5, 4, 3, 2, 1⟩)   ≡ ⟨4, 3, 2, 1, 0⟩
u.UnitTest (SmallerThanCurrent ⟨¯1, 0, 3, ¯2, 1⟩) ≡ ⟨1, 2, 4, 0, 3⟩
u.UnitTest (SmallerThanCurrent ⟨0, 1, 1, 2, 0⟩)   ≡ ⟨1, 3, 3, 4, 1⟩
