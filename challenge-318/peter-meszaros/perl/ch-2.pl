#!/usr/bin/env perl
#
=head1 Task 2: Reverse Equals

Submitted by: Roger Bell_West

You are given two arrays of integers, each containing the same elements as the
other.

Write a script to return true if one array can be made to equal the other by
reversing exactly one contiguous subarray.

=head2 Example 1

    Input: @source = (3, 2, 1, 4)
           @target = (1, 2, 3, 4)
    Output: true

    Reverse elements: 0-2

=head2 Example 2

    Input: @source = (1, 3, 4)
           @target = (4, 1, 3)
    Output: false

=head2 Example 3

    Input: @source = (2)
           @target = (2)
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[3, 2, 1, 4], [1, 2, 3, 4]], 1, "Example 1"],
    [[[1, 3, 4],    [4, 1, 3]],    0, "Example 2"],
    [[[2],          [2]],          1, "Example 3"],
];

sub reverse_equals
{
    my ($source, $target) = @{$_[0]};

    my $len = @$source;

    my $start = 0;
    my $end = $len - 1;

    for (my $i = 0; $i < $len; $i++) {
        if ($source->[$i] != $target->[$i]) {
            $start = $i;
            last;
        }
    }

    for (my $i = $len - 1; $i >= 0; $i--) {
        if ($source->[$i] != $target->[$i]) {
            $end = $i;
            last;
        }
    }

    $source->@[$start .. $end] = reverse $source->@[$start .. $end];

    for (my $i = 0; $i < $len; $i++) {
        return 0 if $source->[$i] != $target->[$i];
    }

    return 1;
}

for (@$cases) {
    is(reverse_equals($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

