#!/usr/bin/env perl

# TASK #1 > Long Year
# Submitted by: Mohammad S Anwar
# Write a script to find all the years between 1900 and 2100 which is a Long
# Year.
#
# A year is Long if it has 53 weeks.
#
#
# [UPDATED][2021-11-01 16:20:00]: For more information about Long Year, please
# refer to wikipedia.
#
# Expected Output
# 1903, 1908, 1914, 1920, 1925,
# 1931, 1936, 1942, 1948, 1953,
# 1959, 1964, 1970, 1976, 1981,
# 1987, 1992, 1998, 2004, 2009,
# 2015, 2020, 2026, 2032, 2037,
# 2043, 2048, 2054, 2060, 2065,
# 2071, 2076, 2082, 2088, 2093,
# 2099

# https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
# years in which 1 January or 31 December are Thursdays

use Modern::Perl;
use DateTime;

sub is_long_year {
    my($year) = @_;
    my $dt = DateTime->new(year => $year, month => 1, day => 1);
    return 1 if $dt->dow == 4;
    $dt = DateTime->new(year => $year, month => 12, day => 31);
    return 1 if $dt->dow == 4;
    return 0;
}

my @years = grep {is_long_year($_)} 1900..2100;

# output in 5 columns
while (@years) {
    my @col = splice(@years, 0, 5);
    say join(", ", @col), @years ? "," : "";
}
