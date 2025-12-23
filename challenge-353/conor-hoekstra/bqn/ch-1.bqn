# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/353-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

MaxWords ← ⌈´≠∘s.Words¨

# Tests
u.UnitTest (MaxWords ⟨"Hello world", "This is a test", "Perl is great"⟩) ≡ 4
u.UnitTest (MaxWords ⟨"Single"⟩) ≡ 1
u.UnitTest (MaxWords ⟨"Short", "This sentence has seven words in total", "A B C", "Just four words here"⟩) ≡ 7
u.UnitTest (MaxWords ⟨"One", "Two parts", "Three part phrase", ""⟩) ≡ 3
u.UnitTest (MaxWords ⟨"The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"⟩) ≡ 10
