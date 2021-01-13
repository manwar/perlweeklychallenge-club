#!/usr/bin/env raku

my @list = (2, 3, 4);

my $sum;

for @list.combinations(2) -> ($n1, $n2) {
   $sum += ($n1 +^ $n2).fmt("%b").comb("1").elems;
}

say $sum;
