# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/360-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

WordSorter ← s.Unwords·(⍋s.Lower)⊸⊏s.Words

# Tests
u.UnitTest (WordSorter "The quick brown fox") ≡ "brown fox quick The"
u.UnitTest (WordSorter "Hello    World!   How   are you?") ≡ "are Hello How World! you?"
u.UnitTest (WordSorter "Hello") ≡ "Hello"
u.UnitTest (WordSorter "Hello, World! How are you?") ≡ "are Hello, How World! you?"
u.UnitTest (WordSorter "I have 2 apples and 3 bananas!") ≡ "2 3 and apples bananas! have I"
