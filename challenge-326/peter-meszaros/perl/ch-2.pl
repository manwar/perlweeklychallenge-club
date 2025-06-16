#!/usr/bin/env perl
#
=head1 Task 2: Decompressed List

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers having even elements.

Write a script to to return the decompress list. To decompress, pick adjacent
pair (i, j) and replace it with j, i times.

=head2 Example 1

    Input: @ints = (1, 3, 2, 4)
    Output: (3, 4, 4)

    Pair 1: (1, 3) => 3 one time  => (3)
    Pair 2: (2, 4) => 4 two times => (4, 4)

=head2 Example 2

    Input: @ints = (1, 1, 2, 2)
    Output: (1, 2, 2)

    Pair 1: (1, 1) => 1 one time  => (1)
    Pair 2: (2, 2) => 2 two times => (2, 2)

=head2 Example 3

    Input: @ints = (3, 1, 3, 2)
    Output: (1, 1, 1, 2, 2, 2)

    Pair 1: (3, 1) => 1 three times => (1, 1, 1)
    Pair 2: (3, 2) => 2 three times => (2, 2, 2)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 3, 2, 4], [3, 4, 4],          "Example 1"],
    [[1, 1, 2, 2], [1, 2, 2],          "Example 1"],
    [[3, 1, 3, 2], [1, 1, 1, 2, 2, 2], "Example 1"],
];

sub decompressed_list
{
    my $ints = shift;

    my @result;
    for (my $i = 0; $i < @$ints; $i += 2) {
        push @result, ($ints->[$i + 1]) x $ints->[$i];
    }
    return \@result;
}

for (@$cases) {
    is(decompressed_list($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
