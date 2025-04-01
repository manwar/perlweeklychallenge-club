# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/315-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

FindWords ← { /⊑¨𝕨⊸∊¨𝕩 }

# Tests
u.UnitTest ('e' FindWords "the"‿"weekly"‿"challenge") ≡ 0‿1‿2
u.UnitTest ('p' FindWords "perl"‿"raku"‿"python")     ≡ 0‿2
u.UnitTest ('b' FindWords "abc"‿"def"‿"bbb"‿"bcd")    ≡ 0‿2‿3
