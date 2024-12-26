# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/301-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

LargestNumber ← ⌈´·•BQN∘∾˘·fn.Permutations•Fmt¨

# Tests
u.UnitTest (LargestNumber ⟨20,3⟩)        ≡ 320
u.UnitTest (LargestNumber ⟨3,30,34,5,9⟩) ≡ 9534330
