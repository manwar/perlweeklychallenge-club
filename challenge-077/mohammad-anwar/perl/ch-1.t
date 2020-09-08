#!/usr/bin/perl

#
# Perl Weekly Challenge - 077
#
# Task #1: Fibonacci Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-077
#

use strict;
use warnings;
use Test::More;
use Test::Deep;
use Algorithm::Combinatorics qw(combinations);

is_deeply(fibonacci_sum(fibonacci_series_upto(6), 6),
          [ [1,5], [1,2,3] ],
          "fibonacci sum = 6");

is_deeply(fibonacci_sum(fibonacci_series_upto(9), 9),
          [ [1,8], [1,3,5] ],
          "fibonacci sum = 9");

done_testing;

#
#
# METHODS

sub fibonacci_sum {
    my ($fibonacci, $sum) = @_;

    my $fibonacci_sum = [];
    foreach my $i (1 .. $sum) {
        last if ($i > @$fibonacci);
        foreach my $comb (combinations($fibonacci, $i)) {
            my $_sum = 0;
            $_sum += $_ for @$comb;
            push @$fibonacci_sum, $comb if ($_sum == $sum);
        }
    }

    return $fibonacci_sum;
}

sub fibonacci_series_upto {
    my ($num) = @_;

    my @fibonacci = (1, 2);
    while ($fibonacci[-1] + $fibonacci[-2] <= $num) {
        push @fibonacci, ($fibonacci[-1] + $fibonacci[-2]);
    }

    return \@fibonacci;
}
