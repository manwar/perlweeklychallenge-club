#!/usr/bin/env perl6 -n

# run as "ch-2a.p6 words.txt"

my %counter = bag <n n a a a b p e p l>;
.say if all(.fc.comb.map: { %counter{$_}-- })

