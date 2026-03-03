# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/363-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

nums ← "zero"‿"one"‿"two"‿"three"‿"four"‿"five"‿"six"‿"seven"‿"eight"‿"nine"

StringLieDetector ← {
    t‿v‿c ← 0‿2‿5 ⊏ s.Words 𝕩 
    (nums ⊐ v‿c)≡⌽(≠t)⊸-⊸⋈ +´"aeiou" ∊˜ t
}

# Tests
u.UnitTest (StringLieDetector "aa — two vowels and zero consonants") ≡ 1
u.UnitTest (StringLieDetector "iv — one vowel and one consonant") ≡ 1
u.UnitTest (StringLieDetector "hello - three vowels and two consonants") ≡ 0
u.UnitTest (StringLieDetector "aeiou — five vowels and zero consonants") ≡ 1
u.UnitTest (StringLieDetector "aei — three vowels and zero consonants") ≡ 1

