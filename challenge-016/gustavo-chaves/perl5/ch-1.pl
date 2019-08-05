#!/usr/bin/env perl

# Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.

# At a party a pie is to be shared by 100 guest. The first guest gets 1% of the
# pie, the second guest gets 2% of the remaining pie, the third gets 3% of the
# remaining pie, the fourth gets 4% and so on.

# Write a script that figures out which guest gets the largest piece of pie.

use 5.026;
use strict;
use warnings;
use bignum;

my $pie = 100/100;

my $largest_slice = 0;

my $guest = 0;

for my $i (1 .. 100) {
    my $slice = $pie * $i / 100;
    $pie -= $slice;
    if ($slice > $largest_slice) {
        $largest_slice = $slice;
        $guest = $i;
    }
    # say "The ${i}º guest got $slice of the total.";
    last if $pie < $largest_slice;
}

say "The ${guest}º guest got the larget pie, which is $largest_slice of the total.";
