# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/326-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Decompress  ← { ∾⥊´¨<˘2‿∘⥊𝕩 } # Explicit
Decompress2 ← ∾·⥊´¨·<˘2‿∘⥊⊢ # Tacit

# Tests
u.UnitTest (Decompress  1‿3‿2‿4) ≡ 3‿4‿4
u.UnitTest (Decompress  1‿1‿2‿2) ≡ 1‿2‿2
u.UnitTest (Decompress  3‿1‿3‿2) ≡ 1‿1‿1‿2‿2‿2
u.UnitTest (Decompress2 1‿3‿2‿4) ≡ 3‿4‿4
u.UnitTest (Decompress2 1‿1‿2‿2) ≡ 1‿2‿2
u.UnitTest (Decompress2 3‿1‿3‿2) ≡ 1‿1‿1‿2‿2‿2
