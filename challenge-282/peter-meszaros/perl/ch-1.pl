#!/usr/bin/env perl
#
=head1 Task 1: Good Integer
Submitted by: Mohammad Sajid Anwar
You are given a positive integer, $int, having 3 or more digits.
Write a script to return the Good Integer in the given integer or -1 if none
found.
    A good integer is exactly three consecutive matching digits.
=head2 Example 1
    Input: $int = 12344456
    Output: "444"
=head2 Example 2
    Input: $int = 1233334
    Output: -1
=head2 Example 3
    Input: $int = 10020003
    Output: "000"
=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [12344456,   "444", 'Example 1'],
    [1233334,       -1, 'Example 2'],
    [10020003,   "000", 'Example 3'],
    [1233334555, "555", 'Example 4'],
];

sub good_integer
{
    my $int = shift;

    while ($int =~ /(.)([0-9])\2\2(?!\2)/g) {
        return $2 x 3 if $1 ne $2;
    }
    return -1;
}

for (@$cases) {
    is(good_integer($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
