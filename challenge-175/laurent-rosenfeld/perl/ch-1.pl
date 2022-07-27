#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Time::Local;

my $yr = shift // 2022;
my @months = (0, 31, is_leap($yr) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

for my $month (1..12) {
    my $month_last_day = timegm( 0, 0, 0, $months[$month], $month - 1, $yr - 1900 );
    my $day_in_week = (gmtime $month_last_day)[6];
    my $sunday = $months[$month] - ($day_in_week % 7);
    printf "%04d/%02d/%02d\n", $yr, $month, $sunday;
}

sub is_leap {
    my $yr = shift;
    return 0 if $yr % 4;    # no if not divisible by 4
    return 1 if $yr % 100;  # yes if divisible by 4 but not by 100
    return 0 if $yr % 400;  # no if divisible by 100 and not by 400
    return 1;               # yes if divisibe by 400
}
