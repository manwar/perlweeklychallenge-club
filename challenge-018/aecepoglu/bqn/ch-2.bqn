cache←{
 Empty⇐{0=≠𝕩}
 Push⇐{(⍋⊑¨)⊸⊏𝕩∾𝕨}
 Pop⇐{(⊏⋈(1↓⊢))𝕩}
}

a←(⍋⊑¨)⊸⊏∘‿2⊸⥊⟨2,"a",1,"b",4,"c"⟩
0=cache.Empty a
1=cache.Empty ∘‿2⊸⥊⟨⟩
0‿"x" cache.Push a
1‿"x" cache.Push a
3‿"x" cache.Push a
5‿"x" cache.Push a
5‿"x" cache.Pop  a
