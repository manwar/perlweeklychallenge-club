#!/usr/bin/env perl

# Perl Weekly Challenge 252 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/

use Modern::Perl;

sub sum_squares_special_nums {
    my(@nums) = @_;
    my $sum = 0;
    for my $i (1 .. @nums) {
        if (scalar(@nums) % $i == 0) {
            $sum += $nums[$i-1] * $nums[$i-1];
        }
    }
    return $sum;
}

say sum_squares_special_nums(@ARGV);
