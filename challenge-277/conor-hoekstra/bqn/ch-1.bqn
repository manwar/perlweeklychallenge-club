# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/277-1.bqn

CountCommon ← +´·⥊≡⌜○((1=≠¨)⊸/⊐⊸⊔)

# Tests
•Show ⟨"Perl", "is", "my", "friend"⟩ CountCommon ⟨"Perl", "and", "Raku", "are", "friend"⟩                                 # 2
•Show ⟨"Perl", "and", "Python", "are", "very", "similar"⟩ CountCommon ⟨"Python", "is", "top", "in", "guest", "languages"⟩ # 1
•Show ⟨"Perl", "is", "imperative", "Lisp", "is", "functional"⟩ CountCommon ⟨"Crystal", "is", "similar", "to", "Ruby"⟩     # 0
