# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/279-1.bqn

SortLetters ← ⍋⊸⊏

# Tests
•Show       ⟨3, 2, 1, 4⟩ SortLetters "REPL"   # PERL
•Show       ⟨2, 4, 1, 3⟩ SortLetters "AURK"   # RAKU
•Show ⟨5, 4, 2, 6, 1, 3⟩ SortLetters "OHYNPT" # PYTHON
