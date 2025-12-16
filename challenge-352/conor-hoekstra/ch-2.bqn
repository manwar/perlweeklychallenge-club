# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/352-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
b ⇐ •Import "/home/cph/bqn-code/lib/binary.bqn"

BinaryPrefix ← 1↓0=5|·b.Decimal¨↑

# Tests
u.UnitTest (BinaryPrefix ⟨0,1,1,0,0,1,0,1,1,1⟩) ≡ ⟨1, 0, 0, 0, 0, 1, 1, 0, 0, 0⟩
u.UnitTest (BinaryPrefix ⟨1,0,1,0,1,0⟩) ≡ ⟨0, 0, 1, 1, 0, 0⟩
u.UnitTest (BinaryPrefix ⟨0,0,1,0,1⟩) ≡ ⟨1, 1, 0, 0, 1⟩
u.UnitTest (BinaryPrefix ⟨1,1,1,1,1⟩) ≡ ⟨0, 0, 0, 1, 0⟩
u.UnitTest (BinaryPrefix ⟨1,0,1,1,0,1,0,0,1,1⟩) ≡ ⟨0, 0, 1, 0, 0, 1, 1, 1, 0, 0⟩
