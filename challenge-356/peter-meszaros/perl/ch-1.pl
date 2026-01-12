#!/usr/bin/env perl
#
=head1 Task 1: Kolakoski Sequence

Submitted by: Mohammad Sajid Anwar

You are given an integer, $int > 3. Write a script to generate the Kolakoski
Sequence of given length $int and return the count of 1 in the generated
sequence. Please follow the wikipedia page for more informations.

=head2 Example 1

    Input: $int = 4
    Output: 2

    (1)(22)(11)(2) => 1221

=head2 Example 2

    Input: $int = 5
    Output: 3

    (1)(22)(11)(2)(1) => 12211

=head2 Example 3

    Input: $int = 6
    Output: 3

    (1)(22)(11)(2)(1)(22) => 122112

=head2 Example 4

    Input: $int = 7
    Output: 4

    (1)(22)(11)(2)(1)(22)(1) => 1221121

=head2 Example 5

    Input: $int = 8
    Output: 4

    (1)(22)(11)(2)(1)(22)(1)(22) => 12211212

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [4, 2, "Example 1"],
    [5, 3, "Example 2"],
    [6, 3, "Example 3"],
    [7, 4, "Example 4"],
    [8, 4, "Example 5"],
];

sub kolakoski_sequence
{
    my $n = shift;
    my @seq = qw/1 2 2/;
    my $index = 2;
    while (@seq < $n) {
        my $count = $seq[$index++];
        my $next_value = ($seq[-1] == 1) ? 2 : 1;
        for (1 .. $count) {
            last if @seq >= $n;
            push @seq, $next_value;
        }
    }
    my $ones_count = grep { $_ == 1 } @seq;
    return $ones_count;
}

for (@$cases) {
    is(kolakoski_sequence($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
