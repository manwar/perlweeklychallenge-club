#!/usr/bin/env perl

# Perl Weekly Challenge 237 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-237/

use Modern::Perl;

say calc_greatness(@ARGV);

sub calc_greatness {
    my(@nums) = @_;
    my @sorted = sort(@nums);
    my $i = 0;
    my $j = 0;
    my $greatness = 0;
    while ($i < @nums && $j < @nums) {
        if ($sorted[$j] > $sorted[$i]) {
            $greatness++;
            $i++;
            $j++;
        }
        else {
            $j++;
        }
    }
    return $greatness;
}
