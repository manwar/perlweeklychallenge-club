# TASK 2 - recreate binary tree
# we would (could) represent a tree in array form and do this rather easily
# but to show the task some respect, we'll build our tree using arrays of len 3
t←⟨1,⟨2, ⟨4, ⟨⟩, ⟨7, ⟨⟩, ⟨⟩⟩⟩, ⟨⟩⟩, ⟨3, ⟨5, ⟨⟩, ⟨⟩⟩, ⟨6, ⟨⟩, ⟨⟩⟩⟩⟩
a←{𝕊⟨⟩:⟨⟩; 𝕊 h‿l‿r: h∾´𝕊¨l‿r} t
{{𝕩(+´≠/⊢)a}} {𝕨𝕊⟨⟩:⟨⟩;𝕨𝕊 h‿l‿r: (𝕎h)‿(𝕨𝕊l)‿(𝕨𝕊r)}t
