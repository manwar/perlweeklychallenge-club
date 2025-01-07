# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/302-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

LargestSet ← { ⌈´(∧´𝕨≥·+´˘"01"=⌜⊢)◶0‿≠¨∾fn.PowerSet𝕩 }

# Tests
u.UnitTest (5‿3 LargestSet  ⟨"10", "0001", "111001", "1", "0"⟩) ≡ 4
u.UnitTest (1‿1 LargestSet  ⟨"10", "1", "0"⟩) ≡ 2
