sub getAge($_) { .comb[11,12].join.Int };
my @list = ("1313579440F2036","2921522980M5644");
@list.grep({ .&getAge >= 60 }).elems.say # 0
