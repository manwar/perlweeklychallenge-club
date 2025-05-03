# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/319-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

WordCount ← +´(∨´·s.IsVowel¨⊑⋈⊢´)¨

# Tests
u.UnitTest (WordCount ⟨"unicode", "xml", "raku", "perl"⟩) ≡ 2
u.UnitTest (WordCount ⟨"the", "weekly", "challenge"⟩) ≡ 2
u.UnitTest (WordCount ⟨"perl", "python", "postgres"⟩) ≡ 0
