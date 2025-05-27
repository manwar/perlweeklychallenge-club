# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/323-2.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

TaxAmount ← {
    b ← fn.Deltas 0∾𝕨⌊⊑¨𝕩 # brackets
    t ← 100÷˜⊢´¨𝕩         # tax rates
    +´b×t
}

TaxAmount2 ← +´(100÷˜⊢´¨)∘⊢×(fn.Deltas 0∾⌊⟜⊑¨)

# Tests
u.UnitTest (10 TaxAmount  ⟨3‿50, 7‿10, 12‿25⟩) ≡ 2.65
u.UnitTest ( 2 TaxAmount  ⟨1‿0, 4‿25, 5‿50⟩)   ≡ 0.25
u.UnitTest ( 0 TaxAmount  ⟨2‿50⟩)              ≡ 0
u.UnitTest (10 TaxAmount2 ⟨3‿50, 7‿10, 12‿25⟩) ≡ 2.65
u.UnitTest ( 2 TaxAmount2 ⟨1‿0, 4‿25, 5‿50⟩)   ≡ 0.25
u.UnitTest ( 0 TaxAmount2 ⟨2‿50⟩)              ≡ 0
