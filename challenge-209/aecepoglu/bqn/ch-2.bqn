Part2←{𝕊ac:
 g←(1-˜≠¨ac)/(↕≠ac) # groups
 e←∾1↓¨ac # emails
 n←⊑¨ac # names
 h←⊏⟜(⌊´¨g⊸⊔)g⊏˜ ⊐e⋈¨g⊏n # new groups
 ((⊑⊏⟜n)¨h⊔g)⋈⊸∾¨(⍷¨h⊔e)
}

>⋈¨Part2 ⟨
 ⟨"A", "a1@a.com", "a2@a.com"⟩,
 ⟨"B", "b1@b.com"⟩,
 ⟨"A", "a3@a.com", "a1@a.com"⟩
⟩
>⋈¨Part2 ⟨
⟨"A", "a1@a.com", "a2@a.com"⟩,
⟨"B", "b1@b.com"⟩,
⟨"A", "a3@a.com"⟩,
⟨"B", "b2@b.com", "b1@b.com"⟩
⟩
