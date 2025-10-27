# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/345-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Reducer ← { i 𝕊 s‿a‿c: { i>0?⟨i∾s,a,0⟩;⟨s,a∾{ c<≠s?c⊑s;¯1 },c+1⟩ } }
LastVisitor ← { 1⊑ ⟨⟩‿⟨⟩‿0 Reducer´ ⌽𝕩 }

# Tests
u.UnitTest (LastVisitor ⟨5, -1, -1⟩) ≡ ⟨5, -1⟩
u.UnitTest (LastVisitor ⟨3, 7, -1, -1, -1⟩) ≡ ⟨7, 3, -1⟩
u.UnitTest (LastVisitor ⟨2, -1, 4, -1, -1⟩) ≡ ⟨2, 4, 2⟩
u.UnitTest (LastVisitor ⟨10, 20, -1, 30, -1, -1⟩) ≡ ⟨20, 30, 20⟩
u.UnitTest (LastVisitor ⟨-1, -1, 5, -1⟩) ≡ ⟨-1, -1, 5⟩
