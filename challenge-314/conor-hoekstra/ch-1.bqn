# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/314-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

EqualStrings ← {
    m ← ⌈´≠¨𝕩
    n ← +´∧`(1=≠∘⍷)˘⍉>m⊸↑¨𝕩
    t ← -´1‿n×(≠∘∾⋈≠)𝕩
    0⊸<◶¯1‿t n
}

# Tests
u.UnitTest (EqualStrings "abc"‿"abb"‿"ab")  ≡  2
u.UnitTest (EqualStrings "ayz"‿"cyz"‿"xyz") ≡ ¯1
u.UnitTest (EqualStrings "yza"‿"yzb"‿"yzc") ≡  3
