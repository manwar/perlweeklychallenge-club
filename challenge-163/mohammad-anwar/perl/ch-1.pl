#!/usr/bin/perl

=head1

Week 163:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-163

Task #1: Sum Bitwise Operator

    You are given list positive numbers, @n.

    Write script to calculate the sum of bitwise & operator for all unique pairs.

=cut

use strict;
use warnings;

use Test::More;
use Algorithm::Combinatorics qw(combinations);

is bitwise_and([1, 2, 3]), 3, 'Example 1';
is bitwise_and([2, 3, 4]), 2, 'Example 2';

done_testing;

#
#
# METHOD

sub bitwise_and {
    my ($numbers) = @_;

    return unless @$numbers;

    my $sum = 0;
    $sum += $_->[0] & $_->[1] for (combinations($numbers, 2));

    return $sum;
}
