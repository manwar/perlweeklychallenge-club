#!/usr/bin/env perl
#
=head1 Task 1: Third Highest

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the Third Highest if found otherwise return the
maximum.

=head2 Example 1

    Input: @array = (5,3,4)
    Output: 3

    First highest is 5. Second highest is 4. Third highest is 3.

=head2 Example 2

    Input: @array = (5,6)
    Output: 6

    First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.

=head2 Example 3

    Input: @array = (5,4,4,3)
    Output: 3

    First highest is 5. Second highest is 4. Third highest is 3.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[5, 3, 4],    3, 'Example 1'],
    [[5, 6],       6, 'Example 2'],
    [[5, 4, 4, 3], 3, 'Example 3'],
];

sub third_highest
{
    my $l = shift;

    my %l = map {$_ => 1} @$l;
    my @l = sort {$b <=> $a} keys %l;

    return $l[2] // $l[0];
}

for (@$cases) {
    is(third_highest($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
