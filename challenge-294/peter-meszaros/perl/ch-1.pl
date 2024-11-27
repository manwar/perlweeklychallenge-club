#!/usr/bin/env perl
#
=head1 Task 1: Consecutive Sequence

Submitted by: Mohammad Sajid Anwar

You are given an unsorted array of integers, @ints.

Write a script to return the length of the longest consecutive elements
sequence. Return -1 if none found. The algorithm must runs in O(n) time.

=head2 Example 1

    Input: @ints = (10, 4, 20, 1, 3, 2)
    Output: 4

    The longest consecutive sequence (1, 2, 3, 4).
    The length of the sequence is 4.

=head2 Example 2

    Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
    Output: 9

=head2 Example 3

    Input: @ints = (10, 30, 20)
    Output: -1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/max/;

my $cases = [
    [[10, 4, 20, 1, 3, 2],           4, 'Example 1'],
    [[0, 6, 1, 8, 5, 2, 4, 3, 0, 7], 9, 'Example 2'],
    [[10, 30, 20],                  -1, 'Example 3'],
];

sub consecutive_sequence
{
    my $l = shift;

    my @l = sort {$a <=> $b} @$l;
    my @seq;
    my $cnt = 1;
    for my $i (1 .. $#$l) {
        if ($l[$i] == ($l[$i-1] + 1)) {
            ++$cnt;
        } elsif ($cnt > 1) {
            push @seq, $cnt;
            $cnt = 1;
        }
    }
    push @seq, $cnt if $cnt > 1;

    return max(@seq) // -1;
}

for (@$cases) {
    is(consecutive_sequence($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
