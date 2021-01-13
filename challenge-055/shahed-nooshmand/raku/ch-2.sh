raku -e '.put for (my \N = [1, 2, 3, 4]).permutations.grep: { all do $_[0](|$_[1]) for |(&infix:«≥», &infix:«≤») xx * Z ($^n[^(*−1)] Z $^n[1..*]) }'
