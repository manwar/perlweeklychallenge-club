# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/310-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

ArrayIntersection ← (∊/⊣)´

# Tests
u.UnitTest (ArrayIntersection ⟨⟨1, 2, 3, 4⟩, ⟨4, 5, 6, 1⟩, ⟨4, 2, 1, 3⟩⟩) ≡ ⟨1, 4⟩
u.UnitTest (ArrayIntersection ⟨⟨1, 0, 2, 3⟩, ⟨2, 4, 5⟩⟩) ≡ ⟨2⟩
u.UnitTest (ArrayIntersection ⟨⟨1, 2, 3⟩, ⟨4, 5⟩, ⟨6⟩⟩) ≡ ⟨⟩
