#!/usr/bin/env perl

# TASK #1 > Workdays
# Submitted by: Mohammad S Anwar
# You are given a year, $year in 4-digits form.
#
# Write a script to calculate the total number of workdays in the given year.
#
# For the task, we consider, Monday - Friday as workdays.
#
# Example 1
# Input: $year = 2021
# Output: 261
# Example 2
# Input: $year = 2020
# Output: 262

use Modern::Perl;
use DateTime;

my $year = shift||DateTime->today()->year();
say count_work_days($year);

sub count_work_days {
    my($year) = @_;
    my $count = 0;
    my $date = DateTime->new(year=>$year, month=>1, day=>1);
    while ($date->year == $year) {
        my $dow = $date->dow;   # 1-monday..7-sunday
        $count++ if $dow<6;
        $date->add(days=>1);
    }
    return $count;
}
