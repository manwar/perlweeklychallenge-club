#!/usr/bin/env perl
#
=head1 Task 1: Beautiful Arrangement

Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a script to return the number of beautiful arrangements that you can
construct.

A permutation of n integers, 1-indexed, is considered a beautiful arrangement
if for every i (1 <= i <= n) either of the following is true:

    1) perm[i] is divisible by i
    2) i is divisible by perm[i]

=head2 Example 1

    Input: $n = 2
    Output: 2

    1st arrangement: [1, 2]
        perm[1] is divisible by i = 1
        perm[2] is divisible by i = 2
    2nd arrangement: [2, 1]
        perm[1] is divisible by i = 1
        i=2 is divisible by perm[2] = 1

=head2 Example 2

    Input: $n = 1
    Output: 1

=head2 Example 3

    Input: $n = 10
    Output: 700

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/permutations/;

my $cases = [
    [ 2,   2, 'Example 1'],
    [ 1,   1, 'Example 2'],
    [10, 700, 'Example 3'],
];

sub beautiful_arrangement
{
    my $int = shift;

    my @data = 1 .. $int;
    my $iter = permutations(\@data);
    my $cnt = 0;
    NEXT_PERM: while (my $p = $iter->next) {
        for my $i (@$p) {
            my $v = $p->[$i-1];
            goto NEXT_PERM if ($i % $v) && ($v % $i);
        }
        ++$cnt;
    }

    return $cnt;
}

for (@$cases) {
    is(beautiful_arrangement($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
