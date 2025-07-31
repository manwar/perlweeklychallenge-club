# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/327-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

MAD ← (⌊´⊸=|∘-´¨)⊸/fn.Pairs

# Tests
u.UnitTest (MAD 4‿1‿2‿3)     ≡ ⟨⟨4,3⟩,⟨1,2⟩,⟨2,3⟩⟩
u.UnitTest (MAD 1‿3‿7‿11‿15) ≡ ⟨⟨1,3⟩⟩
u.UnitTest (MAD 1‿5‿3‿8)     ≡ ⟨⟨1,3⟩,⟨5,3⟩⟩
