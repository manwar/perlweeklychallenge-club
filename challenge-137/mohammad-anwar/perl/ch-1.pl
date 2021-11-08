#!/usr/bin/perl

=head1

Week 137:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-137

Task #1: Long Year

    Write a script to find all the years between 1900 and 2100 which is a Long Year.

=cut

use strict;
use warnings;

use Test::More;
use Date::Calc qw(Week_of_Year Day_of_Week leap_year);

my $exp = [
    1903, 1908, 1914, 1920, 1925,
    1931, 1936, 1942, 1948, 1953,
    1959, 1964, 1970, 1976, 1981,
    1987, 1992, 1998, 2004, 2009,
    2015, 2020, 2026, 2032, 2037,
    2043, 2048, 2054, 2060, 2065,
    2071, 2076, 2082, 2088, 2093,
    2099
];

my $got = [];
foreach (1900 .. 2100) {
    push @$got, $_ if (is_long_year($_));
}

is( join(",", @$exp), join(",", @$got) );

done_testing;

sub is_long_year {
    my ($y) = @_;

    return (
        ((Week_of_Year($y, 12, 31))[0] == 53)
        &&
        ( (leap_year($y))
          ?
          ((Day_of_Week($y, 1, 1) == 3) || (Day_of_Week($y, 12, 31) == 5))
          :
          ((Day_of_Week($y, 1, 1) == 4) || (Day_of_Week($y, 12, 31) == 4))
        )
    );
}
