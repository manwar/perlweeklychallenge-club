# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/314-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

SortColumns ← +´·∧⊸≢˘⍉

# Tests
u.UnitTest (SortColumns >"swpc"‿"tyad"‿"azbe") ≡ 2
u.UnitTest (SortColumns >"cba"‿"daf"‿"ghi") ≡ 1
u.UnitTest (SortColumns >"a"‿"b"‿"c") ≡ 0
