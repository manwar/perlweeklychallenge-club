# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/338-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

HighestRow ← ⌈´+´˘

# Tests
u.UnitTest (HighestRow >⟨⟨4,4,4,4⟩,⟨10,0,0,0⟩,⟨2,2,2,9⟩⟩)          ≡ 16
u.UnitTest (HighestRow >⟨⟨1,5⟩,⟨7,3⟩,⟨3,5⟩⟩)                       ≡ 10
u.UnitTest (HighestRow >⟨⟨1,2,3⟩,⟨3,2,1⟩⟩)                         ≡ 6
u.UnitTest (HighestRow >⟨⟨2,8,7⟩,⟨7,1,3⟩,⟨1,9,5⟩⟩)                 ≡ 17
u.UnitTest (HighestRow >⟨⟨10,20,30⟩,⟨5,5,5⟩,⟨0,100,0⟩,⟨25,25,25⟩⟩) ≡ 100
