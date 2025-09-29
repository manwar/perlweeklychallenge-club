# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/341-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

ReversePrefix ← { ⌽⌾((1+⊑/𝕨=𝕩)⊸↑)𝕩 }

# Tests
u.UnitTest ('g' ReversePrefix "programming") ≡ "gorpramming"
u.UnitTest ('h' ReversePrefix "hello")       ≡ "hello"
u.UnitTest ('h' ReversePrefix "abcdefghij")  ≡ "hgfedcbaij"
u.UnitTest ('s' ReversePrefix "reverse")     ≡ "srevere"
u.UnitTest ('r' ReversePrefix "perl")        ≡ "repl"
