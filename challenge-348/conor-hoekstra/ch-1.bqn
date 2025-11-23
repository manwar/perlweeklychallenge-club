# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/348-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

VowelCount  ← +´∊⟜"AEIOUaeiou" 
StringAlike ← (2÷˜≠)⊸(↓((×⌊≡)○VowelCount)↑)

# Tests
u.UnitTest (StringAlike "textbook") ≡ 0
u.UnitTest (StringAlike "book") ≡ 1
u.UnitTest (StringAlike "AbCdEfGh") ≡ 1
u.UnitTest (StringAlike "rhythmmyth") ≡ 0
u.UnitTest (StringAlike "UmpireeAudio") ≡ 0
