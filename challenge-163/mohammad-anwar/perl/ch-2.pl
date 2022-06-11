#!/usr/bin/perl

=head1

Week 163:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-163

Task #2: Summations

    You are given a list of positive numbers, @n.

    Write a script to find out the summations.

=cut

use strict;
use warnings;

use Test::More;

is summations([1, 2, 3, 4, 5]), 42, 'Example 1';
is summations([1, 3, 5, 7, 9]), 70, 'Example 2';

done_testing;

#
#
# METHOD

sub summations {
    my ($numbers) = @_;

    return unless @$numbers;

    while (@$numbers > 2) {
        my @_numbers = ($numbers->[1]);
        $_numbers[$_] = $numbers->[$_ + 1] + $_numbers[$_ - 1]
            for (1 .. @$numbers-2);
        $numbers = \@_numbers;
    }

    return $numbers->[-1];
}
