#!/usr/bin/env perl

use v5.28;
use warnings;

my @L = (2, 6, 1, 3);

# solution
my @l = sort { $b <=> $a } @L;
my $noble;
for (my $i = 0; $i < @l and $l[$i] >= $i; $i++) {
    $noble = $i if $l[$i] == $i;
}

say defined $noble ? "Noble integer is: $noble" : "There is no noble integer in this set";
