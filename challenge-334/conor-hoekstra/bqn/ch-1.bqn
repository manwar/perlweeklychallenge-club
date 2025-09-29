# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/334-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

RangeSum ← { a‿b𝕊𝕩: +´(1+b-a)↑a↓𝕩 }

# Tests
u.UnitTest (0‿2 RangeSum ⟨¯2,0,3,¯5,2,¯1⟩) ≡ 1
u.UnitTest (1‿3 RangeSum ⟨1,¯2,3,¯4,5⟩)    ≡ ¯3
u.UnitTest (3‿4 RangeSum ⟨1,0,2,¯1,3⟩)     ≡ 2
u.UnitTest (0‿3 RangeSum ⟨¯5,4,¯3,2,¯1,0⟩) ≡ ¯2
u.UnitTest (0‿2 RangeSum ⟨¯1,0,2,¯3,¯2,1⟩) ≡ 1
