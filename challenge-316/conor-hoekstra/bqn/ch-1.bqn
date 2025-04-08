# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/316-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

IsCircular ← ∧´·(=´¯1↓1↓∾)˘2↕(⊑⋈¯1⊸⊑)¨

# Tests
u.UnitTest (IsCircular "perl"‿"loves"‿"scala")          ≡ 1
u.UnitTest (IsCircular "love"‿"the"‿"programming")      ≡ 0
u.UnitTest (IsCircular "java"‿"awk"‿"kotlin"‿"node.js") ≡ 1
