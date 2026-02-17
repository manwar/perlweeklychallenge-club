#!/usr/bin/env perl
#
=head1 Task 1: Zeckendorf Representation

Submitted by: Mohammad Sajid Anwar

You are given a positive integer (<= 100).  Write a script to return Zeckendorf
Representation of the given integer.  Every positive integer can be uniquely
represented as sum of non-consecutive Fibonacci numbers.

=head2 Example 1

    Input: $int = 4
    Output: 3,1

    4 => 3 + 1 (non-consecutive fibonacci numbers)

=head2 Example 2

    Input: $int = 12
    Output: 8,3,1

    12 => 8 + 3 + 1

=head2 Example 3

    Input: $int = 20
    Output: 13,5,2

    20 => 13 + 5 + 2

=head2 Example 4

    Input: $int = 96
    Output: 89,5,2

    96 => 89 + 5 + 2

=head2 Example 5

    Input: $int = 100
    Output: 89,8,3

    100 => 89 + 8 + 3

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [  4,     [3, 1], "Example 1"],
    [ 12,  [8, 3, 1], "Example 2"],
    [ 20, [13, 5, 2], "Example 3"],
    [ 96, [89, 5, 2], "Example 4"],
    [100, [89, 8, 3], "Example 5"],
];

sub zeckendorf_representation
{
    my $n = shift;

    my @fib = (1, 2);
    while ($fib[-1] < $n) {
        push @fib, $fib[-1] + $fib[-2];
    }
    pop @fib if $fib[-1] > $n;

    my @result;
    for my $f (reverse @fib) {
        if ($f <= $n) {
            push @result, $f;
            $n -= $f;
        }
    }
    return \@result;
}

for (@$cases) {
    is(zeckendorf_representation($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
