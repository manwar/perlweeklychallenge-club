Fmt ← '0'+·⌽10|·⌊⊢÷(10⋆↕∘(⌊1+10⋆⁼1⌈|))

MiddleThreeDigits ← {
   0=2|≠Fmt|𝕩 ? "Even # of digits" ;
   3>≠Fmt|𝕩   ? "Too short"        ;
   (3↑(2÷˜¯3+≠)↓⊢)Fmt|𝕩 
}

MiddleThreeDigits 1234567 # "345"
MiddleThreeDigits ¯123    # "123"
MiddleThreeDigits 1       # "Too short"
MiddleThreeDigits 10      # "Even # of digits"
