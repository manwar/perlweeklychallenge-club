# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/294-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

ConsecutiveSequence ← {⌈´¯1∾˜1⊸<⊸/≠¨(¯1=-)fn._ChunkBy⍷∧𝕩}

# Tests
u.UnitTest (ConsecutiveSequence ⟨10, 4, 20, 1, 3, 2⟩          ) ≡ 4
u.UnitTest (ConsecutiveSequence ⟨0, 6, 1, 8, 5, 2, 4, 3, 0, 7⟩) ≡ 9
u.UnitTest (ConsecutiveSequence ⟨10, 30, 20⟩                  ) ≡ -1
