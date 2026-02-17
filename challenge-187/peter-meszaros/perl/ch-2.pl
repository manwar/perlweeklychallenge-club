#!/usr/bin/env perl
#
=head1 Task 2: Magical Triplets

Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n, having at least 3 numbers.  Write
a script to find the triplets (a, b, c) from the given list that satisfies the
following rules.

    1. a + b > c
    2. b + c > a
    3. a + c > b
    4. a + b + c is maximum.

In case, you end up with more than one triplets having the maximum then pick
the triplet where a >= b >= c.

=head2 Example 1

    Input: @n = (1, 2, 3, 2);
    Output: (3, 2, 2)

=head2 Example 2

    Input: @n = (1, 3, 2);
    Output: ()

=head2 Example 3

    Input: @n = (1, 1, 2, 3);
    Output: ()

=head2 Example 4

    Input: @n = (2, 4, 3);
    Output: (4, 3, 2)

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };
use Algorithm::Combinatorics qw/variations/;
use List::Util qw/sum0/;

my $cases = [
    [[1, 2, 3, 2], [3, 2, 2], "Example 1"],
    [[1, 3, 2],           [], "Example 2"],
    [[1, 1, 2, 3],        [], "Example 3"],
    [[2, 4, 3],    [4, 3, 2], "Example 4"],
];

sub magical_triplets
{
    my $n = shift;

    my @triplet;
    my $iter = variations($n, 3);
    while (my $p = $iter->next) {
        my ($a, $b, $c) = @$p;
        if ($a + $b > $c && $b + $c > $a && $a + $c > $b) {
            my $sum_p = sum0(@$p);
            my $sum_t = sum0(@triplet);
            @triplet = @$p if $sum_p > $sum_t || ($sum_p == $sum_t && $a >= $b && $b >= $c);
        }
    }

    return \@triplet;
}

for (@$cases) {
    is(magical_triplets($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
