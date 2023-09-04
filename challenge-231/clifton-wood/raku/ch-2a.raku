sub getAge($_) { .comb[11,12].join.Int };
my @list = ("7868190130M7522","5303914400F9211","9273338290F4010");
@list.grep({ .&getAge >= 60 }).elems.say # 2
