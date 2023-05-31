F←{𝕊a:
a≍ tl←1=(⊢-∞»⊢)a # the tails of sequences (all but firsts)
a≍ h←(«>⊢) tl    # the heads of squences
# name each group,
# remove anything that doesn't belong to any sequence
# perform grouping
# get rid of empty groups
(0<≠¨)⊸/ a⊔˜(+`h)(×-¬∘⊢)(h∨tl)
}
F¨⊸≍⟨1‿3‿4‿5‿7,1‿2‿3‿6‿7‿9,0‿1‿2‿4‿5‿6‿8‿9⟩
