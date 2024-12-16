# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/300-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

BeautifulArrangements ← {
    x‿n       ← (1+↕𝕩)‿0
    Beautiful ← ∧´(|˜∨○(0⊸=)|)⟜x
    { n ↩ n + Beautiful 𝕩 ⋄ fn.Next 𝕩 }•_while_(∨⊸≢) x
    n + Beautiful ⌽x
}

# Tests
u.UnitTest (BeautifulArrangements  1) ≡ 1
u.UnitTest (BeautifulArrangements  2) ≡ 2
u.UnitTest (BeautifulArrangements  3) ≡ 3
u.UnitTest (BeautifulArrangements  4) ≡ 8
u.UnitTest (BeautifulArrangements  5) ≡ 10
u.UnitTest (BeautifulArrangements  6) ≡ 36
u.UnitTest (BeautifulArrangements 10) ≡ 700
