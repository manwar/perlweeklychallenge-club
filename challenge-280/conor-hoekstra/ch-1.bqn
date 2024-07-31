# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/280-1.bqn

AppearsTwice ← ⊑¬∘∊⊸/

# Tests
•Show AppearsTwice "acbddbca" # "d"
•Show AppearsTwice "abccd"    # "c"
•Show AppearsTwice "abcdabbb" # "a"
