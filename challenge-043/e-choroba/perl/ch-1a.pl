#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Math::Combinatorics;

my ($red, $green, $yellow, $blue) = (9, 5, 7, 8);

my $mc = 'Math::Combinatorics'->new(data => [1, 2, 3, 4, 6]);
while (my ($black, $red_green, $black_green, $black_yellow, $blue_yellow)
           = $mc->next_permutation
) {
    my @sums = ($red + $red_green,
                $green + $red_green + $black_green,
                $black + $black_green + $black_yellow,
                $yellow + $black_yellow + $blue_yellow,
                $blue + $blue_yellow);
    say join ' ',
        $red_green, $black_green, $black, $black_yellow, $blue_yellow
        unless grep $_ != 11, @sums;
}
