#!/usr/bin/env perl

# Challenge 219
#
# Task 2: Travel Expenditure
# Submitted by: Mohammad S Anwar
#
# You are given two list, @costs and @days.
#
# The list @costs contains the cost of three different types of travel cards
# you can buy.
#
# For example @costs = (5, 30, 90)
#
# Index 0 element represent the cost of  1 day  travel card.
# Index 1 element represent the cost of  7 days travel card.
# Index 2 element represent the cost of 30 days travel card.
#
# The list @days contains the day number you want to travel in the year.
#
# For example: @days = (1, 3, 4, 5, 6)
#
# The above example means you want to travel on day 1, day 3, day 4, day 5 and
# day 6 of the year.
#
# Write a script to find the minimum travel cost.
# Example 1:
#
# Input: @costs = (2, 7, 25)
#        @days  = (1, 5, 6, 7, 9, 15)
# Output: 11
#
# On day 1, we buy a one day pass for 2 which would cover the day 1.
# On day 5, we buy seven days pass for 7 which would cover days 5 - 9.
# On day 15, we buy a one day pass for 2 which would cover the day 15.
#
# So the total cost is 2 + 7 + 2 => 11.
#
# Example 2:
#
# Input: @costs = (2, 7, 25)
#        @days  = (1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31)
# Output: 20
#
# On day 1, we buy a seven days pass for 7 which would cover days 1 - 7.
# On day 10, we buy a seven days pass for 7 which would cover days 10 - 14.
# On day 20, we buy a one day pass for 2 which would cover day 20.
# On day 30, we buy a one day pass for 2 which would cover day 30.
# On day 31, we buy a one day pass for 2 which would cover day 31.
#
# So the total cost is 7 + 7 + 2 + 2 + 2 => 20.

use Modern::Perl;
use List::Util 'min';

@ARGV>=4 or die "Usage:$0 cost1 cost7 cost30 days...\n";
my($cost1, $cost7, $cost30, @days) = @ARGV;
my $min_cost = calc_min_cost(0, $cost1, $cost7, $cost30, @days);
say $min_cost;

sub calc_min_cost {
    my($total, $cost1, $cost7, $cost30, @days) = @_;

    return $total if @days==0;

    my $total1 = calc_min_cost($total + $cost1, $cost1, $cost7, $cost30, trim_days(1, @days));
    my $total7 = calc_min_cost($total + $cost7, $cost1, $cost7, $cost30, trim_days(7, @days));
    my $total30 = calc_min_cost($total + $cost30, $cost1, $cost7, $cost30, trim_days(30, @days));

    return min($total1, $total7, $total30);
}

sub trim_days {
    my($num_days, @days) = @_;
    die unless @days;
    my $day1 = $days[0];
    while (@days && $days[0] < $day1+$num_days) {
        shift @days;
    }
    return @days;
}
