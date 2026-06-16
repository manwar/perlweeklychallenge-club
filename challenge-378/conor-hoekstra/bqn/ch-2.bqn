# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/378-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
b ⇐ •Import "/home/cph/bqn-code/lib/binary.bqn"

Num ← 10⊸b.Base-⟜'a'
Sow ← Num⊸=⟜(+´Num¨)

# Tests
u.UnitTest ( "cdb" Sow "acb"‿"cba") ≡ 1
u.UnitTest (  "ad" Sow "aab"‿"aac") ≡ 1
u.UnitTest (  "bc" Sow "je"‿"jg")   ≡ 0
u.UnitTest (  "aa" Sow "aaaa"‿"a")  ≡ 1
u.UnitTest (   "h" Sow "d"‿"c")     ≡ 0
u.UnitTest ("bdhd" Sow "gfi"‿"hbf") ≡ 1
