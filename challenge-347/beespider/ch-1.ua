# uiua 0.17.3

FormatDate ← |1 (
  °⊟₃⇌°/$"_ _"
  ⊙(
    ⊓(+₁⨂⍚↙₃Months|⋕◇↘₋₂)
    ∩(⨬($"0_"|∘)⊸≥₁₀)
  )
  $"_-_-_"
)

┌─╴test
  ⍤⤙≍ "2025-01-01" FormatDate "1st Jan 2025"
  ⍤⤙≍ "2025-02-22" FormatDate "22nd Feb 2025"
  ⍤⤙≍ "2025-04-15" FormatDate "15th Apr 2025"
  ⍤⤙≍ "2025-10-23" FormatDate "23rd Oct 2025"
  ⍤⤙≍ "2025-12-31" FormatDate "31st Dec 2025"
└─╴
