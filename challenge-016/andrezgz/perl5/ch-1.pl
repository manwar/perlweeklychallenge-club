#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-016/
# Challenge #1
# Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.
# At a party a pie is to be shared by 100 guest.
# The first guest gets 1% of the pie, the second guest gets 2% of the remaining pie,
# the third gets 3% of the remaining pie, the fourth gets 4% and so on.
# Write a script that figures out which guest gets the largest piece of pie.

use strict;
use warnings;

my $pie = 100;
my %max;

for my $g (1..100) {
    my $slice = $g * $pie / 100;
    last if ($max{slice} && $max{slice} > $slice);
    %max = (guest => $g, slice => $slice);
    $pie -= $slice;
}

print sprintf("Guest %d gets the largest piece of the pie (%.2f%% of it)",$max{guest},$max{slice})."\n";
