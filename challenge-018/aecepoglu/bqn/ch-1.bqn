# Week 18
# Longest common sequence
w←"ABABC"‿"BABCA"‿"ABCBA"
s←(∊⊸/{1↓⥊↕2⥊˜≠𝕩}/¨<∘⊢)∘⊑w  # all nonempty subsets of w
((⌈´=⊢)∘(≠¨)/⊢)s(∧´˘∘(∨´¨⍷⌜)/⊣)w
