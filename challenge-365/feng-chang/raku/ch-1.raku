#!/bin/env raku

unit sub MAIN(Str:D $s, UInt:D $k);

my %h = 'a'..'z' Z=> 1..26;

my $sum = %h{ $s.comb }.join;
$sum = $sum.comb.sum for ^$k;
put $sum;
