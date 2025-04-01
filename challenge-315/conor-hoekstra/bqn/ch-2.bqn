# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/315-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

FindThird ← { (¯1⊸⊑¨/˜𝕨⊸{𝕨≡2↑𝕩}¨)<˘3↕s.Words ¯1↓𝕩 }

# Tests
u.UnitTest ("my"‿"favourite" FindThird "Perl is a my favourite language but Python is my favourite too.") ≡ "language"‿"too"
u.UnitTest ( "a"‿"beautiful" FindThird "Barbie is a beautiful doll also also a beautiful princess.")      ≡ "doll"‿"princess"
u.UnitTest (     "we"‿"will" FindThird "we will we will rock you rock you.")                              ≡ "we"‿"rock"
