#!/usr/bin/env perl
#
=head1

Task 2: Mountain Array

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.
Write a script to return true if the given array is a valid mountain array.
An array is mountain if and only if:

    1) arr.length >= 3
    and
    2) There exists some i with 0 < i < arr.length - 1 such that:
    arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
    arr[i] > arr[i + 1] > ... > arr[arr.length - 1]

=head2 Example 1

    Input: @ints = (1, 2, 3, 4, 5)
    Output: false

=head2 Example 2

    Input: @ints = (0, 2, 4, 6, 4, 2, 0)
    Output: true

=head2 Example 3

    Input: @ints = (5, 4, 3, 2, 1)
    Output: false

=head2 Example 4

    Input: @ints = (1, 3, 5, 5, 4, 2)
    Output: false

=head2 Example 5

    Input: @ints = (1, 3, 2)
    Output: true

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [      [1, 2, 3, 4, 5], false, "Example 1"],
    [[0, 2, 4, 6, 4, 2, 0], true,  "Example 2"],
    [      [5, 4, 3, 2, 1], false, "Example 3"],
    [   [1, 3, 5, 5, 4, 2], false, "Example 4"],
    [            [1, 3, 2], true,  "Example 5"],
];

sub mountain_array
{
    my $ints = shift;
    return false if @$ints < 3;

    my $mountain = false;
    my $up_down = 'up';
    for (my $i = 1; $i < $#$ints; $i++) {
        if ($up_down eq 'up') {
            if ($ints->[$i] > $ints->[$i - 1] && $ints->[$i] > $ints->[$i + 1]) {
                $up_down = 'down';
                $mountain = true;
            } elsif ($ints->[$i] <= $ints->[$i - 1] || $ints->[$i] >= $ints->[$i + 1]) {
                $mountain = false;
                last;
            }
        } else { # down
            if ($ints->[$i] >= $ints->[$i - 1] || $ints->[$i] <= $ints->[$i + 1]) {
                $mountain = false;
                last;
            }

        }
    }
    return $mountain;
}

for (@$cases) {
    is(mountain_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
