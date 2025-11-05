# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/346-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"

LongestParentheses ← ⌈´·((((+´×∧´)0⊸≤)×(0=⊑∘⌽))·+`·-˝"()"=⌜⊢)¨·∾·(¯1↓↓)¨1↓↑

# Tests
u.UnitTest (LongestParentheses "(()())")        ≡ 6
u.UnitTest (LongestParentheses ")()())")        ≡ 4
u.UnitTest (LongestParentheses "((()))()(((()") ≡ 8
u.UnitTest (LongestParentheses "))))((()(")     ≡ 2
u.UnitTest (LongestParentheses "()(()")         ≡ 2
