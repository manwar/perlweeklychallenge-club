# TASK 1
SpiralPack←{𝕊a:
n←⌽a
Dims←(⌊∘√)⊸(⊣⋈÷˜)∘≠
d←Dims n
ss←(⊢∾-)⟨0‿1,1‿0⟩
Rot←{i‿s‿m‿o:⟨i+´ss⊏˜4|s+1‿2, 4|s+1, m, o⟩}
Fit←{i‿·‿·‿·: ∨´i≥d?Rot 𝕩;
     i‿·‿·‿o: i⊑o  ?Rot 𝕩;
              𝕩          }
Put←{𝕨𝕊i‿s‿m‿o:i‿s∾𝕨‿1{𝕨⌾(i⊸⊑)𝕩}¨m‿o}

F←{𝕨𝕊⟨·,s,·,·⟩:•Show Fit •Show (s⊑ss)‿0‿0‿0+ 𝕨Put 𝕩}
⌽2⊑⟨0‿0,0,(0⥊˜d),(0⥊˜d)⟩ F´ n
}
SpiralPack 1‿2‿3‿4
SpiralPack 1‿2‿3‿4‿5‿6
SpiralPack 1+↕12
