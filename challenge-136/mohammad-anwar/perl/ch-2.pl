#!/usr/bin/perl

=head1

Week 136:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-136

Task #2: Fibonacci Sequence

    You are given a positive number $n.

    Write a script to find how many different sequences you can create using Fibonacci numbers where the sum of unique numbers in each sequence are the same as the given number.

=cut

use strict;
use warnings;
use Test::More;
use Algorithm::Combinatorics qw(combinations);

#
#
# DISCLAIMER: This is nearly same as Task #1 of Week 77.

is (fibonacci_sequence(16), 4, 'Example 1');
is (fibonacci_sequence( 9), 2, 'Example 2');
is (fibonacci_sequence(15), 2, 'Example 3');

done_testing;

#
#
# METHODS

sub fibonacci_sequence {
    my ($sum) = @_;

    my $fibonacci     = fibonacci_series_upto($sum);
    my $fibonacci_sum = [];
    foreach my $i (1 .. $sum) {
        last if ($i > @$fibonacci);
        foreach my $comb (combinations($fibonacci, $i)) {
            my $_sum = 0;
            $_sum += $_ for @$comb;
            push @$fibonacci_sum, $comb if ($_sum == $sum);
        }
    }

    return scalar @$fibonacci_sum;
}

sub fibonacci_series_upto {
    my ($num) = @_;

    my @fibonacci = (1, 2);
    while ($fibonacci[-1] + $fibonacci[-2] <= $num) {
        push @fibonacci, ($fibonacci[-1] + $fibonacci[-2]);
    }

    return \@fibonacci;
}
