# part 2
#   (X), (X), bo-b (Y)
#   Bonana-fanna fo-f (Y)
#   Fee fi mo-m (Y)
#   (X)!
# x: name, y: name w/out 1st letter if consonant, don't repeat [b,f,m]
F←(=⟜⊑⊑(⊣(∾⋈⊢)1⊸↓∘⊢))
x←"billy"
•Out¨⟨x∾", "∾x∾", bo-"∾'b'F x   # verse 1
      "bonana-fanna fo-"∾'f'F x # verse 2
      "Fee fi mo-"∾'m'F x⟩      # verse 3
