#!/usr/bin/env perl
#
=head1 Task 2: Travel Expenditure

Submitted by: Mohammad S Anwar

You are given two list, @costs and @days.

The list @costs contains the cost of three different types of travel cards you
can buy.

For example @costs = (5, 30, 90)

	Index 0 element represent the cost of  1 day  travel card.
	Index 1 element represent the cost of  7 days travel card.
	Index 2 element represent the cost of 30 days travel card.

The list @days contains the day number you want to travel in the year.

For example: @days = (1, 3, 4, 5, 6)

The above example means you want to travel on day 1, day 3, day 4, day 5 and
day 6 of the year.

Write a script to find the minimum travel cost.

=head2 Example 1:

	Input: @costs = (2, 7, 25)
		   @days  = (1, 5, 6, 7, 9, 15)
	Output: 11

	On day 1, we buy a one day pass for 2 which would cover the day 1.
	On day 5, we buy seven days pass for 7 which would cover days 5 - 9.
	On day 15, we buy a one day pass for 2 which would cover the day 15.

	So the total cost is 2 + 7 + 2 => 11.

=head2 Example 2:

	Input: @costs = (2, 7, 25)
		   @days  = (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31)
	Output: 20

	On day 1, we buy a seven days pass for 7 which would cover days 1 - 7.
	On day 10, we buy a seven days pass for 7 which would cover days 10 - 14.
	On day 20, we buy a one day pass for 2 which would cover day 20.
	On day 30, we buy a one day pass for 2 which would cover day 30.
	On day 31, we buy a one day pass for 2 which would cover day 31.

	So the total cost is 7 + 7 + 2 + 2 + 2 => 20.
=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/min/;;

my $cases = [
	[[[2,   7, 25], [1, 5, 6, 7, 9, 15]],                         11, 'Example 1'],
	[[[2,   7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]], 20, 'Example 2'],
    [[[3,   8, 20], [2, 4, 6, 7, 8, 10, 17]],                     14, 'Example 3'],
    [[[3, 108, 20], [2, 4, 6, 7, 8, 10, 15]],                     20, 'Example 4'],
];

# Based on https://www.geeksforgeeks.org/minimum-cost-to-complete-given-tasks-if-cost-of-1-7-and-30-days-are-given/
sub travel_expenditure
{
    my $costs = $_[0]->[0];
    my $days  = $_[0]->[1];

    my @cards = (1, 7, 30);
    my (@qmonth, @qweek);
    my $ans = 0;

    for my $day (@$days) {
        while (@qmonth && ($qmonth[0]->[0] + 30) <= $day) {
            shift @qmonth;
        }
        while (@qweek && ($qweek[0]->[0] + 7) <= $day) {
            shift @qweek;
        }
        push @qmonth, [$day, $ans + $costs->[2]];
        push @qweek,  [$day, $ans + $costs->[1]];
        $ans = min($ans + $costs->[0],
                   $qmonth[0]->[1],
                   $qweek[0]->[1]);
    }
    return $ans;
}

for (@$cases) {
    is(travel_expenditure($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
