raku -e '(2..4).combinations(2).map({ (.comb Z≠ sprintf("\%0{.chars}b", @_.min).comb).grep(1) given @_.max.base(2) }).sum.say'
