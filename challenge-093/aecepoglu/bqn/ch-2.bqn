t←⟨1,
   ⟨2,⟨4⟩,⟨⟩⟩
   ⟨3,⟨5⟩,⟨6⟩⟩⟩
MaxSum←{⟨⟩:0; ⟨x⟩:x; ⟨x,l,r⟩:x+⌈´𝕊¨l‿r}
MaxSum t
