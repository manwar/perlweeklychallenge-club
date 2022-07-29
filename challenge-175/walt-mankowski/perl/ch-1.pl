#!/usr/bin/env perl
use v5.36;
use DateTime;

# Task 1: Last Sunday
# Submitted by: Mohammad S Anwar
# Write a script to list Last Sunday of every month in the given year.
# For example, for year 2022, we should get the following:
# 2022-01-30
# 2022-02-27
# 2022-03-27
# 2022-04-24
# 2022-05-29
# 2022-06-26
# 2022-07-31
# 2022-08-28
# 2022-09-25
# 2022-10-30
# 2022-11-27
# 2022-12-25

my $year = $ARGV[0];
for my $month (1..12) {
    my $dt = DateTime->last_day_of_month(year => $year, month => $month);
    my $days_to_sunday = $dt->day_of_week % 7;
    my $final_sunday = $dt->day - $days_to_sunday;
    printf "%d-%02d-%02d\n", $year, $month, $final_sunday;
}
