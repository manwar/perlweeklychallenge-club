# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/312-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

BoxCount  ← { +´3=≠¨⊔´⌽<˘⍉∘‿2⥊-⟜'0'𝕩 } # Explicit
BoxCount2 ← +´3=·≠¨·⊔´·⌽·<˘·⍉∘‿2⥊-⟜'0' # Tacit

# Tests
u.UnitTest (BoxCount  "G0B1R2R0B0")         ≡ 1
u.UnitTest (BoxCount  "G1R3R6B3G6B1B6R1G3") ≡ 3
u.UnitTest (BoxCount  "B3B2G1B3")           ≡ 0
u.UnitTest (BoxCount2 "G0B1R2R0B0")         ≡ 1
u.UnitTest (BoxCount2 "G1R3R6B3G6B1B6R1G3") ≡ 3
u.UnitTest (BoxCount2 "B3B2G1B3")           ≡ 0
