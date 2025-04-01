# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/313-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

BrokenKey ← ≡○fn.Uniq

# Tests
u.UnitTest (         "perrrl" BrokenKey "perl")         ≡ 1
u.UnitTest (       "rrakuuuu" BrokenKey "raku")         ≡ 1
u.UnitTest (           "perl" BrokenKey "python")       ≡ 0
u.UnitTest ("cofffeescccript" BrokenKey "coffeescript") ≡ 1
