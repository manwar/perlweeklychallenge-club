Part1←{list1𝕊list2:
  list1 ⊏˜ ⊑¨(⌊´⊸=+´¨)⊸/(≠list2)(⌊∘÷˜⋈¨|)/⥊list1≡⌜list2
}
"ABC"Part1"CAB"
⟨"Perl", "Raku", "Love"⟩Part1⟨"Raku", "Perl", "Hate","Something"⟩
"ABC"Part1"DEF"
