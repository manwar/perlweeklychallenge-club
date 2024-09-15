#!/usr/bin/env perl
#
=head1 Task 2: Good Triplets

Submitted by: Mohammad S Anwar

You are given an array of integers, @array and three integers $x,$y,$z.

Write a script to find out total Good Triplets in the given array.

A triplet array[i], array[j], array[k] is good if it satisfies the following
conditions:

    b) abs(array[i] - array[j]) <= x
    c) abs(array[j] - array[k]) <= y
    d) abs(array[i] - array[k]) <= z

=head2 Example 1

    Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
    Output: 4

    Good Triplets are as below:
    (3,0,1) where (i=0, j=1, k=2)
    (3,0,1) where (i=0, j=1, k=3)
    (3,1,1) where (i=0, j=2, k=3)
    (0,1,1) where (i=1, j=2, k=3)

=head2 Example 2

    Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[3, 0, 1, 1, 9, 7], [7, 2, 3]], 4, 'Example 1'],
    [[[1, 1, 2, 2, 3],    [0, 0, 1]], 0, 'Example 2'],
];

sub good_triplets
{
    my $l = $_->[0]->[0];
    my ($x, $y, $z) = $_->[0]->[1]->@*;

    my $cnt = 0;
    for my $i (0 .. $#$l) {
        for my $j ($i+1 .. $#$l) {
            for my $k ($j+1 .. $#$l) {
                ++$cnt if abs($l->[$i] - $l->[$j]) <= $x &&
                          abs($l->[$j] - $l->[$k]) <= $y &&
                          abs($l->[$i] - $l->[$k]) <= $z;
            }
        }
    }

    return $cnt;
}

for (@$cases) {
    is(good_triplets($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
