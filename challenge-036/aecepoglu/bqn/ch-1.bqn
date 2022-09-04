w←⟨8,7,6,5,4,3,2,10,0,9,8,7,6,5,4,3,2⟩ # weights
('a'+↕∘≠)⊸≍ v←1+9|18(≤+⊢)↕26 # letter values
c←'X'∾˜1+'0'+↕9 # check digit options

x←"1M8GDM9AXKP042788"
chk←⊑1+c⊐8⊑x
chk=11|+´w×v⊏˜((26×1-⊢)+x-"0A"⊏˜⊢)"A["⍋ x
