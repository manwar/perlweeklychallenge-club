#!/usr/bin/env perl

# Challenge 037
#
# TASK #1
# Write a script to calculate the total number of weekdays (Mon-Fri) in each
# month of the year 2019.
# Jan: 23 days
# Feb: 20 days
# Mar: 21 days
# Apr: 22 days
# May: 23 days
# Jun: 20 days
# Jul: 23 days
# Aug: 22 days
# Sep: 21 days
# Oct: 23 days
# Nov: 21 days
# Dec: 22 days

use Modern::Perl;
use DateTime;

say_work_days(2019);

sub say_work_days {
    my($year) = @_;
    for my $month (1..12) {
        say month_abbrev($month),": ", month_work_days($year, $month), " days";
    }
}

sub month_work_days {
    my($year, $month) = @_;
    my $work_days = 0;
    my $dt = DateTime->new(year => $year, month => $month, day => 1);
    my $month_length = $dt->month_length;
    for my $day (1 .. $month_length) {
        my $dow = $dt->day_of_week;
        $work_days++ if $dow < 6;       # mon(1) to fri(5), not sat(6), sun(7)
        $dt->add(days => 1);
    }
    return $work_days;
}

sub month_abbrev {
    my($month) = @_;
    my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
    return $months[$month-1];
}
