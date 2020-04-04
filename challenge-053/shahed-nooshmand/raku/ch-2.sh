raku -e '.say for <a e i o u>.combinations(get).map(*.permutations.map(*.join))[*;*].grep({!m/ao|au|ea|eo|eu|oe|oi|ua|ui/}).sort'
