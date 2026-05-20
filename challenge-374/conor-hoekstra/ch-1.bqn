# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/374-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Av ← "aeiou"⊸(∧´∊∾∊˜)
Cv ← Av¨⊸/·∾·↓¨↑

# Tests
u.UnitTest (Cv "aeiou") ≡ ⟨"aeiou"⟩
u.UnitTest (Cv "aaeeeiioouu") ≡ ⟨"aaeeeiioou", "aeeeiioou", "aaeeeiioouu", "aeeeiioouu"⟩
u.UnitTest (Cv "aeiouuaxaeiou") ≡ ⟨"aeiou","aeiouu", "aeiouua", "eiouua", "aeiou"⟩
u.UnitTest (Cv "uaeiou") ≡ ⟨"uaeio", "uaeiou", "aeiou"⟩
u.UnitTest (Cv "aeioaeioa") ≡ ⟨⟩
