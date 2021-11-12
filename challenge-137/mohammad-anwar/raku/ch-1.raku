#!/usr/bin/env raku

=begin pod

Week 137:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-137

Task #1: Long Year

    Write a script to find all the years between 1900 and 2100 which is a Long Year.

=end pod

use Test;

my $exp = [
    1903, 1908, 1914, 1920, 1925,
    1931, 1936, 1942, 1948, 1953,
    1959, 1964, 1970, 1976, 1981,
    1987, 1992, 1998, 2004, 2009,
    2015, 2020, 2026, 2032, 2037,
    2043, 2048, 2054, 2060, 2065,
    2071, 2076, 2082, 2088, 2093,
    2099,
];

my $got = [];
for 1900 .. 2100 -> $y { push $got, $y if long-year($y); }

is-deeply [ |$got ], [ |$exp ], 'Task Example';

done-testing;

#
#
# METHODS

sub long-year(Int $y where $y > 0 --> Bool) {

    my $first_day = Date.new("$y-01-01");
    my $last_day  = Date.new("$y-12-31");

    return $last_day.week-number == 53
           &&
           ( $first_day.is-leap-year     &&
             $first_day.day-of-week == 3 ||
             $last_day.day-of-week  == 5
           )
           ||
           ( $first_day.day-of-week == 4 ||
             $last_day.day-of-week  == 4
           );
}
