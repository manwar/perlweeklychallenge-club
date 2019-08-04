#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use constant FEBRUARY => 2;
use constant FRIDAY => 4; # 1/1/1900 is a Monday so offset of 4 for Friday.
use constant WEEK => 7;

sub isLeap {
    my ($year) = @_;

    # years divisible by 100 are not leap years unless they are divisble by 400.
    return ($year % 4 == 0 && ($year % 100 != 0 || $year % 400 == 0));
}

my @days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

my $elapsedDays = -31;

for my $year (1900 .. 2019) {
    for my $month (0 .. 11) {
        $elapsedDays += $days[$month];
        if (isLeap($year) && $month == FEBRUARY) {
            $elapsedDays++;
        }
        if ($days[$month] == 31 && $elapsedDays % WEEK == FRIDAY) {
            say sprintf("%02d/%d", $month + 1, $year);
        }
    }
}
