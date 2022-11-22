# Likely some group theory at play here
# Given A, B, C
# A->C ≡ {A->B, B->C}
# But this doesn't help me with anything practical
#
#
# Find the deviation
# Apply effective diffs to it
#  (by decrementing positive vals and incrementing negative vals)
#  until solution found
F←{G←{·‿x:0≠+´x?¯1‿x
     ;n‿x:      𝕩+d⋈˜|-´/|d←-∊⊸××x}
   ⊑ G •_while_ {n‿x:(n≥0)∧(∨´0≠x)} 0⋈ (≠⥊+´÷≠)⊸- 𝕩}
4 = F 1‿0‿5
¯1 = F 1‿0‿0
