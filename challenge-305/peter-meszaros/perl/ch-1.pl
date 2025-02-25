#!/usr/bin/env perl
#
=head1 Task 1: Binary Prefix

Submitted by: Mohammad Sajid Anwar

You are given a binary array.

Write a script to return an array of booleans where the partial binary number
up to that point is prime.

=head2 Example 1

    Input: @binary = (1, 0, 1)
    Output: (false, true, true)

    Sub-arrays (base-10):
    (1): 1 - not prime
    (1, 0): 2 - prime
    (1, 0, 1): 5 - prime

=head2 Example 2

    Input: @binary = (1, 1, 0)
    Output: (false, true, false)

    Sub-arrays (base-10):
    (1): 1 - not prime
    (1, 1): 3 - prime
    (1, 1, 0): 6 - not prime

=head2 Example 3

    Input: @binary = (1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
    Output: (false, true, true, false, false, true, false, false, false, false,
        false, false, false, false, false, false, false, false, false, true)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 0, 1], [0, 1, 1], 'Example 1'],
    [[1, 1, 0], [0, 1, 0], 'Example 2'],
    [[1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1], [0, 1, 1, 0,
            0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], 'Example 3'],
];

sub is_prime
{
    my $n = shift;

    return 0 if $n <= 1;

    for my $i (2 .. int(sqrt($n))) {
        return 0 unless $n % $i;
    }

    return 1;
}

sub binary_prefix
{
    my $l = shift;

    my $ret = [];
    for my $i (0 .. $#$l) {
        my $n = 0;
        for my $j (0 .. $i) {
            $n = $n * 2 + $l->[$j];
        }
        $ret->[$i] = is_prime($n);
    }

    return $ret;
}

for (@$cases) {
    is(binary_prefix($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
