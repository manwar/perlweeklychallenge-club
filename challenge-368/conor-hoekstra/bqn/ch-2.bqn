# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/368-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
p ⇐ •Import "/home/cph/bqn-code/lib/primes.bqn"

Blo ← { ≠𝕨◶⟨⍷,⊢⟩p.Factor𝕩 }

# Tests
u.UnitTest (0 Blo 100061) ≡ 3
u.UnitTest (0 Blo 971088) ≡ 3
u.UnitTest (1 Blo 63640)  ≡ 6
u.UnitTest (1 Blo 988841) ≡ 2
u.UnitTest (0 Blo 211529) ≡ 2
