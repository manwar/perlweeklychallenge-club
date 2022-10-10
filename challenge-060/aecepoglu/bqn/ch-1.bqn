a←'A'+↕26
⊏⟜a 1-˜26 _dc 28
tbl←{a⊏˜(⊢-⌽∘(1⌊↕∘≠))26 _dc 1-˜𝕩}¨1+↕100

28⊑tbl       # excel column for given number
tbl⊑∘⊐⟜⋈"AD" # decimal number for given excel column
