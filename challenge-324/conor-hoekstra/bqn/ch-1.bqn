# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/324-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Make2dArray ← ⥊

# Tests
u.UnitTest (2‿2 Make2dArray 1‿2‿3‿4) ≡ >⟨⟨1,2⟩,⟨3,4⟩⟩
u.UnitTest (1‿3 Make2dArray 1‿2‿3) ≡ >⟨⟨1,2,3⟩⟩
u.UnitTest (4‿1 Make2dArray 1‿2‿3‿4) ≡ >⟨⟨1⟩,⟨2⟩,⟨3⟩,⟨4⟩⟩
