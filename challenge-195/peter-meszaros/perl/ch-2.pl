#!/usr/bin/env perl
#
=head1 Task 2: Most Frequent Even

Submitted by: Mohammad S Anwar

You are given a list of numbers, @list.  Write a script to find most frequent
even numbers in the list. In case you get more than one even numbers then
return the smallest even integer. For all other case, return -1.

=head2 Example 1

    Input: @list = (1,1,2,6,2)
    Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears the most.

=head2 Example 2

    Input: @list = (1,3,5,7)
    Output: -1 since no even numbers found in the list

=head2 Example 3

    Input: @list = (6,4,4,6,1)
    Output: 4 since there are only two even numbers 4 and 6. They both appears the equal number of times, so pick the smallest.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[1, 1, 2, 6, 2], 2, "Example 1"],
    [[1, 3, 5, 7],   -1, "Example 2"],
    [[6, 4, 4, 6, 1], 4, "Example 3"],
];

sub most_frequent_even
{
    my $list = shift;
    my %freq;

    for my $num (@$list) {
        $freq{$num}++ if $num % 2 == 0;
    }

    my $most_frequent = -1;
    my $highest_count = 0;

    for my $num (keys %freq) {
        if ($freq{$num} > $highest_count) {
            $highest_count = $freq{$num};
            $most_frequent = $num;
        } elsif ($freq{$num} == $highest_count) {
            $most_frequent = $num if $num < $most_frequent;
        }
    }

    return $most_frequent;
}

for (@$cases) {
    is(most_frequent_even($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
