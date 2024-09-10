#!/usr/bin/env perl
#
=head1 Task 1: Consecutive Odds

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to print 1 if there are THREE consecutive odds in the given
array otherwise print 0.

=head2 Example 1

    Input: @array = (1,5,3,6)
    Output: 1

=head2 Example 2

    Input: @array = (2,6,3,5)
    Output: 0

=head2 Example 3

    Input: @array = (1,2,3,4)
    Output: 0

=head2 Example 4

    Input: @array = (2,3,5,7)
    Output: 1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 5, 3, 6], 1, 'Example 1'],
    [[2, 6, 3, 5], 0, 'Example 2'],
    [[1, 2, 3, 4], 0, 'Example 3'],
    [[2, 3, 5, 7], 1, 'Example 4'],
];

sub consecutive_odds
{
    my $l = shift;

    for my $i (0 .. $#$l-2) {
        return 1 if $l->[$i]   % 2 &&
                    $l->[$i+1] % 2 &&
                    $l->[$i+2] % 2;
    }
    return 0;
}

for (@$cases) {
    is(consecutive_odds($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
