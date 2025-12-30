# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/354-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

MinAbsDiff ← {
    m ← ⌊´·fn.Deltas∧ 𝕩
    (m=-˜´¨)⊸/∧∧¨∾⋈fn._Tri 𝕩
}

# Tests
u.UnitTest (MinAbsDiff ⟨4, 2, 1, 3⟩)      ≡ ⟨⟨1, 2⟩, ⟨2, 3⟩, ⟨3, 4⟩⟩
u.UnitTest (MinAbsDiff ⟨10, 100, 20, 30⟩) ≡ ⟨⟨10, 20⟩, ⟨20, 30⟩⟩
u.UnitTest (MinAbsDiff ⟨¯5, ¯2, 0, 3⟩)    ≡ ⟨⟨¯2, 0⟩⟩
u.UnitTest (MinAbsDiff ⟨8, 1, 15, 3⟩)     ≡ ⟨⟨1, 3⟩⟩
u.UnitTest (MinAbsDiff ⟨12, 5, 9, 1, 15⟩) ≡ ⟨⟨9, 12⟩, ⟨12, 15⟩⟩
