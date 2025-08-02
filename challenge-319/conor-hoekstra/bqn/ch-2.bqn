# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/319-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

MinimumCommon ← ×∘≠◶¯1‿(⌊´)∊/⊣

# Tests
u.UnitTest (⟨3, 4, 5, 6⟩ MinimumCommon ⟨1, 2, 3, 4⟩) ≡ 3
u.UnitTest (   ⟨1, 2, 3⟩ MinimumCommon ⟨2, 4⟩)       ≡ 2
u.UnitTest (⟨1, 2, 3, 4⟩ MinimumCommon ⟨5, 6, 7, 8⟩) ≡ ¯1
