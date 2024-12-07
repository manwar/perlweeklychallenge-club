# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/298-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

RightInterval ← {
    f‿l ← (⊑¨⋈⊢´¨)𝕩
    f fn.Iono (⌊´/⟜(f⊸×))˘l≤⌜f
}

# Tests
u.UnitTest (RightInterval ⟨⟨3,4⟩,⟨2,3⟩,⟨1,2⟩⟩) ≡ ⟨-1, 0, 1⟩
u.UnitTest (RightInterval ⟨⟨1,4⟩,⟨2,3⟩,⟨3,4⟩⟩) ≡ ⟨-1, 2, -1⟩
u.UnitTest (RightInterval ⟨⟨1,4⟩,⟨2,2⟩,⟨3,4⟩⟩) ≡ ⟨-1, 1, -1⟩
u.UnitTest (RightInterval ⟨⟨1,2⟩⟩)             ≡ ⟨-1⟩
