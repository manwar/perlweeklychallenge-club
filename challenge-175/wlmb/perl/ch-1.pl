#!/usr/bin/env perl
# Perl weekly challenge 175
# Task 1: Last Sunday
#
# See https://wlmb.github.io/2022/07/25/PWC175/#task-1-last-sunday
use v5.36;
use DateTime;
die "Usage: $0 Y1 [Y2...]\nto print the last Sundays of years Y1, Y2...\n"
    unless @ARGV;
foreach my $year(@ARGV){
    say "\nLast Sundays of year $year:";
    say $_->subtract(days=>$_->day_of_week%7)->ymd for
        map {DateTime->last_day_of_month(year=>$year, month=>$_)} (1..12)
}
