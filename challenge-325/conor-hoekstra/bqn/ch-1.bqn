# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/325-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Mco ← ⌈´(+×⊢)`

# Tests
u.UnitTest (Mco 0‿1‿1‿0‿1‿1‿1) ≡ 3
u.UnitTest (Mco 0‿0‿0‿0) ≡ 0
u.UnitTest (Mco 1‿0‿1‿0‿1‿1) ≡ 2
