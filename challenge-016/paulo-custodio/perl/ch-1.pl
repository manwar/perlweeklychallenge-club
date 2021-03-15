#!/usr/bin/perl

# Challenge 016
#
# Task #1
# Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.
#
# At a party a pie is to be shared by 100 guest. The first guest gets 1% of the
# pie, the second guest gets 2% of the remaining pie, the third gets 3% of the
# remaining pie, the fourth gets 4% and so on.
#
# Write a script that figures out which guest gets the largest piece of pie.

use strict;
use warnings;
use 5.030;

my $pie = 1;
my @guest_slice;
for my $guest (1..100) {
    my $slice = $guest/100*$pie;
    $pie -= $slice;
    push @guest_slice, [$guest => $slice];
}

@guest_slice = reverse sort {$a->[1]<=>$b->[1]} @guest_slice;

say "Guest ",$guest_slice[0][0], " gets ",
    sprintf("%.4f", $guest_slice[0][1]*100), "% of the pie.";
