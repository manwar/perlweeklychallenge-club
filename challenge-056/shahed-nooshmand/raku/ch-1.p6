#!/usr/bin/env raku

my @N = 2, 7, 9;
my $k = 2;

for ^@N -> $i {
    my $j = (@N[$i] + $k) 🔎 @N[$i+1..*];
    say $i, " ", 1 + $i + $j with $j
}
