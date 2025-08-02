#!/usr/bin/env perl

use v5.40;

use List::Util 'min';

my @ints = (1, 2, 3, 4, 5);

# Solution
sub is_strong ($x, $y) {
    return 0 < abs($x - $y) < min($x, $y);
}

my @strong_pair_strings;
for my $j (1 .. $#ints) {
    my $y = $ints[$j];
    for my $i (0 .. $j-1) {
        my $x = $ints[$i];
        push @strong_pair_strings, "($x, $y)" if is_strong($x, $y);
    }
}

say "Strong pairs: ", join ', ', @strong_pair_strings;