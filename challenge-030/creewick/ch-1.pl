#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

# And you can change these constants to get the solution for day other than Christmas, or for other day of week

my $currentDayOfWeek = 3;
my $currentYear = 2019;
my $REQUESTED_DAY_OF_WEEK = 0;
my $DAYS_IN_WEEK = 7;
my $DAYS_IN_YEAR = 365;

sub getNextWeekDay {
    my ($prevDay, $isLeap) = @_;
    my $days = 365 + $isLeap;

    return ($prevDay + $days) % $DAYS_IN_WEEK;
}

# And you can change the definition of the leap year, for example, to include centuries in them

sub isLeapYear {
    my ($year) = @_;

    return $year % 4 > 0
        ? 0
        : $year % 100 > 0
            ? 1
            : $year % 400 == 0;
}

while ($currentYear < 2100) {
    my $isLeap = isLeapYear(++$currentYear);
    $currentDayOfWeek = getNextWeekDay($currentDayOfWeek, $isLeap);

    if ($currentDayOfWeek == $REQUESTED_DAY_OF_WEEK) {
       say $currentYear;
    }
}