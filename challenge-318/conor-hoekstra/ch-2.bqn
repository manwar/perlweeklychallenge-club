# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/318-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Rev ← { a‿b𝕊𝕩: ⌽⌾(a↑b↓⊢)𝕩 }
ReverseEquals ← { ∨´𝕨⊸≡¨Rev⟜𝕩¨∾1⊸+⊸((⌽⊣)↑¨(<˘⋈⌜))↕≠𝕩 }

# Tests
u.UnitTest (⟨1,2,3,4⟩ ReverseEquals ⟨3,2,1,4⟩) ≡ 1
u.UnitTest (  ⟨1,3,4⟩ ReverseEquals ⟨4,1,3⟩  ) ≡ 0
u.UnitTest (      ⟨2⟩ ReverseEquals ⟨2⟩      ) ≡ 1
