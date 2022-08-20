# BQN has support for complex numbers (https://mlochbaum.github.io/BQN/spec/complex.html)
# but CBQN (the compiler) does not (yet)

# similarly there is no built-in date library so we won't bother with challenge-2
# The difficult bit is with calculating day-of-week
# We could use •SH and call shell util "date" if we had to



# finds how many digits are required to represent a number in base ¯4
# it works for numbers between -4⋆14 and 4⋆15 (inclusive)
Len←{ 1+⊑⟨1⟩⊐˜𝕩((𝕩<0)◶≤‿≥)+`(¯4⋆↕∘≠)⊸×3×((𝕩<0)◶¬‿⊢)2|↕15 }

To2i←{ #length 𝕊 decimal_value
 a←𝕩 (⊏⊢/˜⊣=(+´⊢×¯4⋆(⌽∘↕∘≠)∘⊢)˘∘⊢) >⥊↕𝕨⥊4 # in base ¯4
 {a⌾(𝕩⊸/)𝕩}(0=2|↕1-˜2×𝕨)                  # in base 2i
}
From2i←(+´⊢×¯4⋆(⌽∘↕∘≠)∘⊢)∘((0=2|↕∘≠)⊸/)   # base ¯4 first, calculate next

# ⌽⎉1⍉(Len⊸To2i)¨⊸≍¯20+↕100 # table view
# (From2i¨(Len⊸To2i)¨)⊸≡¯20+↕100 # test
