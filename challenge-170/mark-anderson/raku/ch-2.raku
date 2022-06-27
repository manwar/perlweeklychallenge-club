#!/usr/bin/env raku

my $a := < 1 2 >,
         < 3 4 >;

my $b := < 5 6 >,
         < 7 8 >;

say map { .[0] X* .[1] }, ($a X $b);
