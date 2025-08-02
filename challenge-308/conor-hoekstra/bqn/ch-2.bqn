# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/308-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Xor ← { ⊑𝕨⟨32⟩•bit._xor⟨𝕩⟩ } # TODO: has to be a better way to do this
DecodeXor ← { Xor`𝕨∾𝕩 }

# Tests
u.UnitTest (1 DecodeXor ⟨1, 2, 3⟩)    ≡ ⟨1, 0, 2, 1⟩
u.UnitTest (4 DecodeXor ⟨6, 2, 7, 3⟩) ≡ ⟨4, 2, 0, 7, 4⟩
