#!/bin/env raku

unit sub MAIN(Str:D $s);

my $c;
for $s.comb {
    when 0..9 { print ($c.ord + $_).chr }
    default   { $c = $_; .print         }
}
put '';
