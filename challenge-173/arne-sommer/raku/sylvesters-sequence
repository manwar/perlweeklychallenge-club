#! /usr/bin/env raku

unit sub MAIN (Int $count where $count > 0 = 10);

my $ss := (my $sum = 2, { my $c = $sum +1; $sum *= $c; $c } ... Inf);

say $ss[^$count].join("\n");
