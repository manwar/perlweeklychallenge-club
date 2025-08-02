#!/usr/bin/env perl
#
=head1 Task 2: Last Element

Submitted by: Mohammad Sajid Anwar

You are given a array of integers, @ints.

Write a script to play a game where you pick two biggest integers in the given
array, say x and y. Then do the following:

    a) if x == y then remove both from the given array
    b) if x != y then remove x and replace y with (y - x)

At the end of the game, there is at most one element left.

Return the last element if found otherwise return 0.

=head2 Example 1

    Input: @ints = (3, 8, 5, 2, 9, 2)
    Output: 1

    Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
    Step 2: pick 3 and 5 => (2, 2, 1, 2)
    Step 3: pick 2 and 1 => (1, 2, 2)
    Step 4: pick 2 and 1 => (1, 2)
    Step 5: pick 1 and 2 => (1)

=head2 Example 2

    Input: @ints = (3, 2, 5)
    Output: 0

    Step 1: pick 3 and 5 => (2, 2)
    Step 2: pick 2 and 2 => ()

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[3, 8, 5, 2, 9, 2], 1, 'Example 1'],
    [[3, 2, 5],          0, 'Example 2'],
];

sub last_element
{
    my $l = shift;

    while (@$l > 1) {
        my @sorted = sort { $b <=> $a } @$l;
        my $x = shift @sorted;
        my $y = shift @sorted;
        push @sorted, $x - $y if $x != $y;
        $l = \@sorted;
    }
    return @$l ? $l->[0] : 0;
}

for (@$cases) {
    is(last_element($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
