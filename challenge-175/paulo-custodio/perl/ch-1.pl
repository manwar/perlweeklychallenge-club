#!/usr/bin/env perl

# Challenge 175
#
# Task 1: Last Sunday
# Submitted by: Mohammad S Anwar
#
# Write a script to list Last Sunday of every month in the given year.
#
# For example, for year 2022, we should get the following:
#
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

use Modern::Perl;
use DateTime;

sub last_sunday_month {
    my($year, $month) = @_;
    my $date = DateTime->last_day_of_month(year=>$year, month=>$month);
    $date->add(days=>-1) while $date->day_of_week() != 7;
    return $date;
}

sub last_sunday_year {
    my($year) = @_;
    return map {last_sunday_month($year, $_)} 1..12;
}

@ARGV==1 or die "usage: ch-1.pl year\n";
my $year = shift;
say $_->ymd for last_sunday_year($year);
