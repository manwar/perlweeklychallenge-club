# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/374-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

Lsdn  ← ⌈´·•BQN¨fn.Group
Lsdn2 ← {⌈´•BQN¨1↓𝕩⊔˜+`1∾≠´˘2↕𝕩} # https://arraybox.dev/#Sjzi

# Tests
u.UnitTest (Lsdn "6777133339") ≡ 3333
u.UnitTest (Lsdn "1200034") ≡ 4
u.UnitTest (Lsdn "44221155") ≡ 55
u.UnitTest (Lsdn "88888") ≡ 88888
u.UnitTest (Lsdn "11122233") ≡ 222
