#!/usr/bin/env perl
#
=head1 Task 2: Array Formation

Submitted by: Mohammad Sajid Anwar

You are given two list: @source and @target.

Write a script to see if you can build the exact @target by putting these
smaller lists from @source together in some order. You cannot break apart or
change the order inside any of the smaller lists in @source.

=head2 Example 1

    Input: @source = ([2,3], [1], [4])
           @target = (1, 2, 3, 4)
    Output: true

    Use in the order: [1], [2,3], [4]

=head2 Example 2

    Input: @source = ([1,3], [2,4])
           @target = (1, 2, 3, 4)
    Output: false

=head2 Example 3

    Input: @source = ([9,1], [5,8], [2])
           @target = (5, 8, 2, 9, 1)
    Output: true

    Use in the order: [5,8], [2], [9,1]

=head2 Example 4

    Input: @source = ([1], [3])
           @target = (1, 2, 3)
    Output: false

    Missing number: 2

=head2 Example 5

    Input: @source = ([7,4,6])
           @target = (7, 4, 6)
    Output: true

    Use in the order: [7, 4, 6]

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[[[2,3], [1], [4]],   [1, 2, 3, 4]],    true,  "Example 1"],
    [[[[1,3], [2,4]],      [1, 2, 3, 4]],    false, "Example 2"],
    [[[[9,1], [5,8], [2]], [5, 8, 2, 9, 1]], true,  "Example 3"],
    [[[[1], [3]],          [1, 2, 3]],       false, "Example 4"],
    [[[[7,4,6]],           [7, 4, 6]],       true,  "Example 5"],
];

sub array_formation
{
    my $source = $_[0]->[0];
    my $target = $_[0]->[1];

    sub _equal_arrays
    {
        my $source = shift;
        my $target = shift;

        return false if @$source != @$target;
        for my $i (0 .. $#$source) {
            return false if $source->[$i] != $target->[$i];
        }
        return true;
    }

    for my $i (0 .. $#$source) {
        my $subarray = $source->[$i];
        my $len = @$subarray;

        my $found = false;
        for my $j (0 .. $#$target - $len + 1) {
            my $target_slice = [ $target->@[$j .. $j + $len - 1] ];
            if (_equal_arrays($subarray, $target_slice)) {
                splice(@$target, $j, $len);
                $found = true;
                last;
            }
        }
        return false unless $found;
    }
    return @$target == 0 ? true : false;
}

for (@$cases) {
    is(array_formation($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
