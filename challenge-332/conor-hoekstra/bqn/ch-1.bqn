# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/332-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
b ⇐ •Import "/home/cph/bqn-code/lib/binary.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

BinaryDate ← { "-" s.Join (∾•Fmt¨)¨ b.Binary¨ s.Nats 𝕩 }

# Tests
u.UnitTest (BinaryDate "2025-07-26") ≡ "11111101001-111-11010"
u.UnitTest (BinaryDate "2000-02-02") ≡ "11111010000-10-10"
u.UnitTest (BinaryDate "2024-12-31") ≡ "11111101000-1100-11111"
