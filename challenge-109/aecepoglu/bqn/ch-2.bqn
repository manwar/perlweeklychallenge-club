# TASK 2
# abcdefg
# ab bcd def fg
Perm←{𝕊0:0‿0⥊0; # permutation table with 𝕩 columns
      >⟨⟨0⟩⟩{n𝕊a:⥊(1+a){𝕨⌾(𝕩⊸/)n⥊0}⌜<˘¬=⌜˜↕n}´⌽1(⊣↓+)↕𝕩}
      
bs←<˘"ab"‿"bcd"‿"def"‿"fg"(∨´∘=⌜)"abcdefg"
{1=+´∊bs+´∘/¨<𝕩}˘⊸/ 1+Perm 7
