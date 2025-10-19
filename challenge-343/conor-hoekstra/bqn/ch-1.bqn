# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/343-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

ZeroFriend ← ⌊´·|0⊸-

# Tests
u.UnitTest (ZeroFriend⟨4, 2, -1, 3, -2⟩)     ≡ 1
u.UnitTest (ZeroFriend⟨-5, 5, -3, 3, -1, 1⟩) ≡ 1
u.UnitTest (ZeroFriend⟨7, -3, 0, 2, -8⟩)     ≡ 0
u.UnitTest (ZeroFriend⟨-2, -5, -1, -8⟩)      ≡ 1
u.UnitTest (ZeroFriend⟨-2, 2, -4, 4, -1, 1⟩) ≡ 1
