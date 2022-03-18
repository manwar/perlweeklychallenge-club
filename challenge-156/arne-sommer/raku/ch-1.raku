#! /usr/bin/env raku

unit sub MAIN (Int $length where $length > 0 = 10);

my $pn := (1..Inf).grep({ $_.fmt('%b').comb.sum.is-prime });

$pn.head($length).join(", ").say;
