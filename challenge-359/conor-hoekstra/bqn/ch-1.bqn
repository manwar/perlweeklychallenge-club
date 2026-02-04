# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/359-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
b ⇐ •Import "/home/cph/bqn-code/lib/binary.bqn"

Help   ← { 𝕩<10 ? 𝕨⋈𝕩 ; (𝕨+1)𝕊 +´b.Digits 𝕩 }
PAndDr ← { 0 Help 𝕩 } # Persistance and digital root

# Tests
u.UnitTest (PAndDr 38) ≡ ⟨2, 2⟩
u.UnitTest (PAndDr 7) ≡ ⟨0, 7⟩
u.UnitTest (PAndDr 999) ≡ ⟨2, 9⟩
u.UnitTest (PAndDr 1999999999) ≡ ⟨3, 1⟩
u.UnitTest (PAndDr 101010) ≡ ⟨1, 3⟩
