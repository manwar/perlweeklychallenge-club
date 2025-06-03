# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/324-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

Xor ← {⊑𝕨⟨32⟩•bit._xor⟨𝕩⟩} # TODO has to be a better way to do this

TotalXor ←  +´·Xor´¨1↓fn.PowerSet

# Tests
u.UnitTest (TotalXor 1‿3)         ≡ 6
u.UnitTest (TotalXor 5‿1‿6)       ≡ 28
u.UnitTest (TotalXor 3‿4‿5‿6‿7‿8) ≡ 480
