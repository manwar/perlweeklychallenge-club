# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/298-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

MaximalSquare ← ×˜·⊢´∘/↕∘⌊´∘≢(∨´∘⥊·(∧´⥊)⎉2⋈˜⊸↕)¨<

# Tests
a ← >⟨⟨1, 0, 1, 0, 0⟩,
      ⟨1, 0, 1, 1, 1⟩,
      ⟨1, 1, 1, 1, 1⟩,
      ⟨1, 0, 0, 1, 0⟩⟩
u.UnitTest (MaximalSquare a)           ≡ 4
u.UnitTest (MaximalSquare 2‿2⥊0‿1‿1‿0) ≡ 1
u.UnitTest (MaximalSquare 1‿1⥊0)       ≡ 0
