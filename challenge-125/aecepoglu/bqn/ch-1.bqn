# TAKS 1
n←13
F←{d←1+⌈2÷˜×˜𝕩 # upper bound
   s←×˜↕d # squares
   allpairs←d(⌊∘÷˜⋈|)¨/s∊˜⥊(|-×+)⌜˜↕d
   (∨´˘𝕩⊸=)⊸/>∊⊸/(∧⊢∾s⊑∘⊐·|∘-´⋆⟜2)¨(<´∧(2=+´∘∊)∧(∧´0⊸≠))¨⊸/allpairs }
F 8
