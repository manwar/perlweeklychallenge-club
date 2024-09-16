#!/usr/bin/env perl
#
=head1 Task 2: Widest Valley

Submitted by: E. Choroba

Given a profile as a list of altitudes, return the leftmost widest valley. A
valley is defined as a subarray of the profile consisting of two parts: the
first part is non-increasing and the second part is non-decreasing. Either part
can be empty.

=head2 Example 1

    Input: 1, 5, 5, 2, 8
    Output: 5, 5, 2, 8

=head2 Example 2

    Input: 2, 6, 8, 5
    Output: 2, 6, 8

=head2 Example 3

    Input: 9, 8, 13, 13, 2, 2, 15, 17
    Output: 13, 13, 2, 2, 15, 17

=head2 Example 4

    Input: 2, 1, 2, 1, 3
    Output: 2, 1, 2

=head2 Example 5

    Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
    Output: 3, 3, 2, 1, 2, 3, 3

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 5,  5,  2, 8],               [ 5,  5, 2, 8],            'Example 1'],
    [[2, 6,  8,  5],                  [ 2,  6, 8],               'Example 2'],
    [[9, 8, 13, 13, 2, 2, 15, 17],    [13, 13, 2, 2, 15, 17],    'Example 3'],
    [[2, 1,  2,  1, 3],               [ 2,  1, 2],               'Example 4'],
    [[1, 3,  3,  2, 1, 2,  3,  3, 2], [ 3,  3, 2, 1,  2,  3, 3], 'Example 5'],
];

sub get_valley
{
    my $lst = shift;
    my $curr = shift;

    while ($curr < $#$lst) {
        last if $lst->[$curr+1] > $lst->[$curr];
        ++$curr;
    }
    while ($curr < $#$lst) {
        last if $lst->[$curr+1] < $lst->[$curr];
        ++$curr;
    }
    return $curr;
}

sub widest_valley
{
    my $l = shift;

    my @valley;
    for my $start (0 .. $#$l-1) {
        my $end = get_valley($l, $start);
        @valley = $l->@[$start .. $end] if ($end - $start + 1) > @valley;
    }

    return \@valley;
}

for (@$cases) {
    is(widest_valley($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

