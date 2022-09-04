Perm←{𝕊0:0‿0⥊0; # permutation table with 𝕩 columns
      >⟨⟨0⟩⟩{n𝕊a:⥊(1+a){𝕨⌾(𝕩⊸/)n⥊0}⌜<˘¬=⌜˜↕n}´⌽1(⊣↓+)↕𝕩}

n←3
k←4
(4-1)⊏ 1+⍋⊸⊏Perm 3
