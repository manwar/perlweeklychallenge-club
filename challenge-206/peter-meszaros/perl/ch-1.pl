#!/usr/bin/env perl
#
=head1 Task 1: Shortest Time

Submitted by: Mohammad S Anwar

You are given a list of time points, at least 2, in the 24-hour clock format
HH:MM.

Write a script to find out the shortest time in minutes between any two time
points.

=head2 Example 1

    Input: @time = ("00:00", "23:55", "20:00")
    Output: 5

    Since the difference between "00:00" and "23:55" is the shortest (5 minutes).

=head2 Example 2

    Input: @array = ("01:01", "00:50", "00:57")
    Output: 4

=head2 Example 3

    Input: @array = ("10:10", "09:30", "09:00", "09:55")
    Output: 15

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["00:00", "23:55", "20:00"],           5, 'Example 1'],
    [["01:01", "00:50", "00:57"],           4, 'Example 2'],
    [["10:10", "09:30", "09:00", "09:55"], 15, 'Example 3'],
];

sub shortest_time
{
    my $l = shift;

    my @l;
    for my $t (@$l) {
        my ($h, $m) = split ':', $t;
        push @l, $h * 60 + $m || 1440;
    }
    my $min = 24 * 60;
    for my $i (0 .. $#l-1) {
        for my $j ($i+1 .. $#l) {
            my $diff = abs($l[$i] - $l[$j]);
            $min = $diff if $diff < $min;
        }
    }
    return $min;
}

for (@$cases) {
    is(shortest_time($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
