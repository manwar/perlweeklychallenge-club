#!/usr/bin/env raku

=begin pod

Week 138:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-138

Task #1: Workdays

    You are given a year in 4-digits form. Write a script to calculate the total number of workdays in the given year.

=end pod

use Test;

is workdays(2021), 261, 'Example 1';
is workdays(2020), 262, 'Example 2';

done-testing;

#
#
# METHODS

sub workdays(Int $year where $year > 0 --> Int) {

    my Int $y = $year;
    my $date  = Date.new("$y-01-01");
    my $workdays = 0;

    while $year == $y {
        ($date.day-of-week < 6) and $workdays++;
        $date++ and $y = $date.year;
    }

    return $workdays;
}
