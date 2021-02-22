#!/usr/bin/perl

# Challenge 019
#
# Task #1
# Write a script to display months from the year 1900 to 2019 where you find
# 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.
#
# Solution: 4 weeks are 28 days, to have 5 week-ends we need additional 3 days (29,30,31),
# therefore 31st must be a Sunday

use strict;
use warnings;
use 5.030;
use constant Sunday => 7;

sub is_leap {
    my($year) = @_;
    return ((($year % 4)==0 && ($year % 100)!=0) || ($year % 400)==0) ? 1 : 0;
}

sub days_in_month {
    my($year, $month) = @_;
    my @dom = (31, 28+is_leap($year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    return $dom[$month-1];
}

sub day_of_year {
    my($year, $month, $day) = @_;
    my $dayno = $day;
    $dayno += days_in_month($year, $_) for (1 .. $month-1);
    return $dayno;
}

# return 1..7 <=> Monday..Sunday
sub day_of_week {
    my($year, $month, $day) = @_;
    my $dayno = day_of_year($year, $month, $day);
    my $wdnog = ($dayno + $year + int(($year-1)/4) - int(($year-1)/100)
                 + int(($year-1)/400) - 2) % 7 + 1;
    return $wdnog;
}

for my $year (1900 .. 2019) {
    for my $month (1 .. 12) {
        say sprintf("%04d-%02d", $year, $month) if five_weekends($year, $month);
    }
}


sub five_weekends {
    my($year, $month) = @_;
    return days_in_month($year, $month)==31 && day_of_week($year, $month, 31)==Sunday;
}
