# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/330-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

TitleCapital  ← { s.Unwords (2<≠)◶⊢‿(s.Upper⌾⊑)¨ s.Words s.Lower 𝕩 } # Explicit
TitleCapital2 ← s.Unwords·(2<≠)◶⊢‿(s.Upper⌾⊑)¨·s.Words s.Lower       # Tacit

# Tests
u.UnitTest (TitleCapital  "PERL IS gREAT")        ≡ "Perl is Great"
u.UnitTest (TitleCapital  "THE weekly challenge") ≡ "The Weekly Challenge"
u.UnitTest (TitleCapital  "YoU ARE A stAR")       ≡ "You Are a Star"
u.UnitTest (TitleCapital2 "PERL IS gREAT")        ≡ "Perl is Great"
u.UnitTest (TitleCapital2 "THE weekly challenge") ≡ "The Weekly Challenge"
u.UnitTest (TitleCapital2 "YoU ARE A stAR")       ≡ "You Are a Star"
