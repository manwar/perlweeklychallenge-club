# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/322-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
s  ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

Tf ← '-'s.Join fn.Chunk⟜∾                                        # tail format
Sf ← { n𝕊x:{ n>≠⊑𝕩 ? (⊑𝕩)∾"-"∾n Tf 1↓𝕩 ; n Tf 𝕩 } '-'s.Split x } # string format

# Tests
u.UnitTest (3 Sf "ABC-D-E-F") ≡ "ABC-DEF"
u.UnitTest (2 Sf "A-BC-D-E")  ≡ "A-BC-DE"
u.UnitTest (4 Sf "-A-B-CD-E") ≡ "A-BCDE"
