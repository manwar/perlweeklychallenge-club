# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/305-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

AlienSort  ← { 𝕩⊏˜⍋𝕨⊸⊐¨𝕩 } # Explicit
AlienSort2 ← ⍋∘(⊐˜¨⟜<)˜⊏⊢  # Tacit

# Tests
u.UnitTest ("hlabydefgirkmnopqjstuvwxcz" AlienSort  ⟨"perl", "python", "raku"⟩) ≡ ⟨"raku", "python", "perl"⟩
u.UnitTest ("corldabtefghijkmnpqswuvxyz" AlienSort  ⟨"the", "weekly", "challenge"⟩) ≡ ⟨"challenge", "the", "weekly"⟩
u.UnitTest ("hlabydefgirkmnopqjstuvwxcz" AlienSort2 ⟨"perl", "python", "raku"⟩) ≡ ⟨"raku", "python", "perl"⟩
u.UnitTest ("corldabtefghijkmnpqswuvxyz" AlienSort2 ⟨"the", "weekly", "challenge"⟩) ≡ ⟨"challenge", "the", "weekly"⟩
