# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/377-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

P  ← (⊑∾⟜0)⍷
H  ← { h ← ⊑𝕩 ⋄ t ← 1↓𝕩 ⋄ +´((⌽h)⊸P¨⌽¨t)∧h⊸P¨t }
Ps ← { +´H¨⌽⟜𝕩¨(↕≠𝕩) } 

# Tests
u.UnitTest (Ps ⟨"a", "aba", "ababa", "aa"⟩) ≡ 4
u.UnitTest (Ps ⟨"pa", "papa", "ma", "mama"⟩) ≡ 2
u.UnitTest (Ps ⟨"abao", "ab"⟩) ≡ 0
u.UnitTest (Ps ⟨"abab", "abab"⟩) ≡ 2
u.UnitTest (Ps ⟨"ab", "abab", "ababab"⟩) ≡ 3
u.UnitTest (Ps ⟨"abc", "def", "ghij"⟩) ≡ 0
