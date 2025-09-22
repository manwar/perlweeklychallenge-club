# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/339-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

MaxProductDiff  ← { ⌈´{ 𝕊a‿b‿c‿d: (a×b)-c×d }¨4 fn.ChooseWR 𝕩 } # solution 1
MaxProductDiff2 ← { ⌈´{ -´×˝2‿2⥊𝕩 }¨4 fn.ChooseWR 𝕩 }           # solution 2 (explicit)
MaxProductDiff3 ← ⌈´·(-´·×˝2‿2⊸⥊)¨4⊸fn.ChooseWR                 # solution 3 (tacit)

# Tests
u.UnitTest (MaxProductDiff ⟨5, 9, 3, 4, 6⟩)   ≡ 42
u.UnitTest (MaxProductDiff ⟨1, ¯2, 3, ¯4⟩)    ≡ 10
u.UnitTest (MaxProductDiff ⟨¯3, ¯1, ¯2, ¯4⟩)  ≡ 10
u.UnitTest (MaxProductDiff ⟨10, 2, 0, 5, 1⟩)  ≡ 50
u.UnitTest (MaxProductDiff ⟨7, 8, 9, 10, 10⟩) ≡ 44

u.UnitTest (MaxProductDiff2 ⟨5, 9, 3, 4, 6⟩)   ≡ 42
u.UnitTest (MaxProductDiff2 ⟨1, ¯2, 3, ¯4⟩)    ≡ 10
u.UnitTest (MaxProductDiff2 ⟨¯3, ¯1, ¯2, ¯4⟩)  ≡ 10
u.UnitTest (MaxProductDiff2 ⟨10, 2, 0, 5, 1⟩)  ≡ 50
u.UnitTest (MaxProductDiff2 ⟨7, 8, 9, 10, 10⟩) ≡ 44

u.UnitTest (MaxProductDiff3 ⟨5, 9, 3, 4, 6⟩)   ≡ 42
u.UnitTest (MaxProductDiff3 ⟨1, ¯2, 3, ¯4⟩)    ≡ 10
u.UnitTest (MaxProductDiff3 ⟨¯3, ¯1, ¯2, ¯4⟩)  ≡ 10
u.UnitTest (MaxProductDiff3 ⟨10, 2, 0, 5, 1⟩)  ≡ 50
u.UnitTest (MaxProductDiff3 ⟨7, 8, 9, 10, 10⟩) ≡ 44
