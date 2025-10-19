# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/343-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

TeamChampion ← ⊑·/·⌈´⊸=+´˘

# Tests
u.UnitTest (TeamChampion >⟨⟨0, 1, 1⟩, ⟨0, 0, 1⟩, ⟨0, 0, 0⟩⟩)                        ≡ 0
u.UnitTest (TeamChampion >⟨⟨0, 1, 0, 0⟩, ⟨0, 0, 0, 0⟩, ⟨1, 1, 0, 0⟩, ⟨1, 1, 1, 0⟩⟩) ≡ 3
u.UnitTest (TeamChampion >⟨⟨0, 1, 0, 1⟩, ⟨0, 0, 1, 1⟩, ⟨1, 0, 0, 0⟩, ⟨0, 0, 1, 0⟩⟩) ≡ 0
u.UnitTest (TeamChampion >⟨⟨0, 1, 1⟩, ⟨0, 0, 0⟩, ⟨0, 1, 0⟩⟩)                        ≡ 0
u.UnitTest (TeamChampion >⟨⟨0, 0, 0, 0, 0⟩, ⟨1, 0, 0, 0, 0⟩, ⟨1, 1, 0, 1, 1⟩, ⟨1, 1, 0, 0, 0⟩, ⟨1, 1, 0, 1, 0⟩⟩) ≡ 2
