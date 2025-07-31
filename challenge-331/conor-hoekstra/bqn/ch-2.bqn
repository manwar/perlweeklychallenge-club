# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/331-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

Dup          ← 1=·⌈´⊒
MatchAndDup  ← ≡∧Dup∘⊢
Swappable    ← (≠/⊣)((4=≠∘∾)∧≡)(⌽≠/⊢)
BuddyStrings ← Swappable ∨ MatchAndDup 

# Tests
u.UnitTest ("fuck" BuddyStrings "fcuk") ≡ 1
u.UnitTest ("love" BuddyStrings "love") ≡ 0
u.UnitTest ("fodo" BuddyStrings "food") ≡ 1
u.UnitTest ("feed" BuddyStrings "feed") ≡ 1
