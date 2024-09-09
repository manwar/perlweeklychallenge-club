#!/usr/bin/env perl
#
=head1 Task 2: Array Pairings

Submitted by: Mohammad S Anwar

You are given an array of integers having even number of elements..

Write a script to find the maximum sum of the minimum of each pairs.

=head2 Example 1

    Input: @array = (1,2,3,4)
    Output: 4

    Possible Pairings are as below:
    a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
    b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
    c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3

    So the maxium sum is 4.

=head2 Example 2

    Input: @array = (0,2,1,3)
    Output: 2

    Possible Pairings are as below:
    a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
    b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
    c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1

    So the maximum sum is 2.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/partitions/;
use List::Util qw/min/;

my $cases = [
    [[1, 2, 3, 4], 4, 'Example 1'],
    [[0, 2, 1, 3], 2, 'Example 2'],
];

sub array_pairings
{
    my $l = shift;

    my $max = 0;
    my $iter = partitions($l, @$l/2);
    PARTITION: while (my $c = $iter->next) {
        my $v = 0;
        for my $e (@$c) {
            next PARTITION if @$e != 2;
            $v += min(@$e);
        }
        $max = $v if $v > $max;
    }
    return $max;
}

for (@$cases) {
    is(array_pairings($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
