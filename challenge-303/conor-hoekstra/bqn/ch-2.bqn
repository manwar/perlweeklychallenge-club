# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/303-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Rm  ← (¬∘∊/⊣)⟜((-⋈+)⟜1)
Rec ← { 0=≠𝕩 ? 𝕨 ; h‿t ← (⊑¨⋈1⊸↓¨)(↕∘≠⌽¨<)𝕩 ⋄ (𝕨+h)𝕊¨t Rm¨h }
Max ← ⌈´·∾´⍟(1-˜≡)0⊸Rec # TODO: probably no need for ∾´⍟(1-˜≡)

# Tests
u.UnitTest (Max ⟨3,4,2⟩)       ≡ 6
u.UnitTest (Max ⟨2,2,3,3,3,4⟩) ≡ 9
u.UnitTest (Max ⟨2,4,6,9,10⟩)  ≡ 22
