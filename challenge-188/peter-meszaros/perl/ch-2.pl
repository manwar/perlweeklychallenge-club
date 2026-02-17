#!/usr/bin/env perl
#
=head1
Task 2: Total Zero

Submitted by: Mohammad S Anwar

You are given two positive integers $x and $y.  Write a script to find out the
number of operations needed to make both ZERO.  Each operation is made up
either of the followings:

    $x = $x - $y if $x >= $y

or

    $y = $y - $x if $y >= $x (using the original value of $x)

=head2 Example 1

    Input: $x = 5, $y = 4
    Output: 5

=head2 Example 2

    Input: $x = 4, $y = 6
    Output: 3

=head2 Example 3

    Input: $x = 2, $y = 5
    Output: 4

=head2 Example 4

    Input: $x = 3, $y = 1
    Output: 3

=head2 Example 5

    Input: $x = 7, $y = 4
    Output: 5

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[5, 4], 5, "Example 1"],
    [[4, 6], 3, "Example 2"],
    [[2, 5], 4, "Example 3"],
    [[3, 1], 3, "Example 4"],
    [[7, 4], 5, "Example 5"],
];

sub total_zero
{
    my $x = $_[0]->[0];
    my $y = $_[0]->[1];

    my $count = 0;
    while ($x > 0 && $y > 0) {
        if ($x >= $y) {
            $x -= $y;
        } else {
            $y -= $x;
        }
        $count++;
    }
    return $count;
}

for (@$cases) {
    is(total_zero($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
