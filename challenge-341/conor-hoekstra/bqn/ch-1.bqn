# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/341-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

BrokenKeyboard  ← { +´¬∨´¨𝕨⊸∊¨s.Words s.Lower 𝕩 }

# Tests
u.UnitTest ( "d" BrokenKeyboard  "Hello World")          ≡ 1
u.UnitTest ("ae" BrokenKeyboard  "apple banana cherry")  ≡ 0
u.UnitTest (  "" BrokenKeyboard  "Coding is fun")        ≡ 3
u.UnitTest ("ab" BrokenKeyboard  "The Weekly Challenge") ≡ 2
u.UnitTest ( "p" BrokenKeyboard  "Perl and Python")      ≡ 1
