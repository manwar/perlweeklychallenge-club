# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/327-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Missing ← (1+↕∘≠)⊸(¬∘∊/⊣)

# Tests
u.UnitTest (Missing 1‿2‿1‿3‿2‿5) ≡ 4‿6
u.UnitTest (Missing 1‿1‿1)       ≡ 2‿3
u.UnitTest (Missing 2‿2‿1)       ≡ ⋈3
