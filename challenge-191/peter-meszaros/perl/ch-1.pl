#!/usr/bin/env perl
#
=head1 Task 1: Twice Largest

Submitted by: Mohammad S Anwar

You are given list of integers, @list.  Write a script to find out whether the
largest item in the list is at least twice as large as each of the other items.

=head2 Example 1

    Input: @list = (1,2,3,4)
    Output: -1

    The largest in the given list is 4. However 4 is not greater than twice of every remaining elements.
    1 x 2 <= 4
    2 x 2 <= 4
    2 x 3 >  4

=head2 Example 2

    Input: @list = (1,2,0,5)
    Output: 1

    The largest in the given list is 5. Also 5 is greater than twice of every remaining elements.
    1 x 2 <= 5
    2 x 2 <= 5
    0 x 2 <= 5

=head2 Example 3

    Input: @list = (2,6,3,1)
    Output: 1

    The largest in the given list is 6. Also 6 is greater than twice of every remaining elements.
    2 x 2 <= 6
    3 x 2 <= 6
    1 x 2 <= 6

=head2 Example 4

    Input: @list = (4,5,2,3)
    Output: -1

    The largest in the given list is 5. Also 5 is not greater than twice of every remaining elements.
    4 x 2 >  5
    2 x 2 <= 5
    3 x 2 >  5

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[1, 2, 3, 4], -1, 'Example 1'],
    [[1, 2, 0, 5],  1, 'Example 2'],
    [[2, 6, 3, 1],  1, 'Example 3'],
    [[4, 5, 2, 3], -1, 'Example 4'],
];

sub twice_largest
{
    my $list = shift;
    my @sorted = sort { $b <=> $a } @$list;
    my $largest = shift @sorted;
    for my $i (@sorted) {
        return -1 if $i * 2 > $largest;
    }
    return 1;
}

for (@$cases) {
    is(twice_largest($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
