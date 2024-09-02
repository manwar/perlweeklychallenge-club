#!/usr/bin/env perl
#
=head1 Task 2: Duplicate and Missing

Submitted by: Mohammad S Anwar

You are given an array of integers in sequence with one missing and one
duplicate.

Write a script to find the duplicate and missing integer in the given array.
Return -1 if none found.

For the sake of this task, let us assume the array contains no more than one
duplicate and missing.

=head2 Example 1:

    Input: @nums = (1,2,2,4)
    Output: (2,3)

    Duplicate is 2 and Missing is 3.

=head2 Example 2:

    Input: @nums = (1,2,3,4)
    Output: -1

    No duplicate and missing found.

=head2 Example 3:

    Input: @nums = (1,2,3,3)
    Output: (3,4)

    Duplicate is 3 and Missing is 4.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::MoreUtils qw/duplicates/;

my $cases = [
    [[1, 2, 2, 4], [2, 3], 'Example 1'],
    [[1, 2, 3, 4],     [], 'Example 2'],
    [[1, 2, 3, 3], [3, 4], 'Example 3'],
];

sub duplicate_and_missing
{
    my $l = shift;

    my @res = duplicates @$l;
    for my $i (1 .. $#$l) {
        my $v = $l->[$i-1] + 1;
        if ($l->[$i] != $v) {
            push @res, $v;
            last;
        }
    }
    return \@res;
}

for (@$cases) {
    is(duplicate_and_missing($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
