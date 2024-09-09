#!/usr/bin/env perl
#
=head1 Task 1: Special Quadruplets

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the total special quadruplets for the given array.

Special Quadruplets are such that satisfies the following 2 rules.

    1) nums[a] + nums[b] + nums[c] == nums[d]
    2) a < b < c < d

=head2 Example 1

    Input: @nums = (1,2,3,6)
    Output: 1

    Since the only special quadruplets found is
    $nums[0] + $nums[1] + $nums[2] == $nums[3].

=head2 Example 2

    Input: @nums = (1,1,1,3,5)
    Output: 4

    $nums[0] + $nums[1] + $nums[2] == $nums[3]
    $nums[0] + $nums[1] + $nums[3] == $nums[4]
    $nums[0] + $nums[2] + $nums[3] == $nums[4]
    $nums[1] + $nums[2] + $nums[3] == $nums[4]

=head2 Example 3

    Input: @nums = (3,3,6,4,5)
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/combinations/;


my $cases = [
    [[1, 2, 3, 6],    1, 'Example 1'],
    [[1, 1, 1, 3, 5], 4, 'Example 2'],
    [[3, 3, 6, 4, 5], 0, 'Example 3'],
];

sub special_quadruples
{
    my $l = shift;

    my $cnt = 0;
    my $iter = combinations($l, 4);
    while (my $c = $iter->next) {
        ++$cnt if ($c->[0] + $c->[1] + $c->[2]) == $c->[3];
    }
    return $cnt;
}

for (@$cases) {
    is(special_quadruples($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
