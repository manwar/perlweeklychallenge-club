#!/usr/bin/env perl
#
=head1 Task 1: Zero Friend

Submitted by: Mohammad Sajid Anwar

You are given a list of numbers.

Find the number that is closest to zero and return its distance to zero.

=head2 Example 1

    Input: @nums = (4, 2, -1, 3, -2)
    Output: 1

    Values closest to 0: -1 and 2 (distance = 1 and 2)

=head2 Example 2

    Input: @nums = (-5, 5, -3, 3, -1, 1)
    Output: 1

    Values closest to 0: -1 and 1 (distance = 1)

=head2 Example 3

    Input: @ums = (7, -3, 0, 2, -8)
    Output: 0

    Values closest to 0: 0 (distance = 0)
    Exact zero wins regardless of other close values.

=head2 Example 4

    Input: @nums = (-2, -5, -1, -8)
    Output: 1

    Values closest to 0: -1 and -2 (distance = 1 and 2)

=head2 Example 5

    Input: @nums = (-2, 2, -4, 4, -1, 1)
    Output: 1

    Values closest to 0: -1 and 1 (distance = 1)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[ 4,  2, -1,  3, -2],    1, "Example 1"],
    [[-5,  5, -3,  3, -1, 1], 1, "Example 2"],
    [[ 7, -3,  0,  2, -8],    0, "Example 3"],
    [[-2, -5, -1, -8],        1, "Example 4"],
    [[-2,  2, -4,  4, -1, 1], 1, "Example 5"],
];

sub zero_friend
{
    my $nums = shift;

    my $min = undef;
    for my $n (@$nums) {
        my $abs = abs($n);
        $min = $abs if !defined $min || $abs < $min;
    }
    return $min;
}

for (@$cases) {
    is(zero_friend($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
