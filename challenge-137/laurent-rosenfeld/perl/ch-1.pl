#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Time::Local;

sub is_leap_year {
    my $year = shift;
    return 0 if $year % 4;   # not divisible by 4
    return 1 if $year % 100; # divisible by 4, not by 100
    return 0 if $year % 400; # divisible by 100, not by 400
    return 1;                # divisible by 400
}

for my $year (1900..2100) {
    my $date = timegm(0, 0, 0, 1, 0, $year);
    my $day_in_week = (gmtime $date)[6];
    print $year, ", " if $day_in_week == 4; # 4 = Thursday
    print $year, ", " if $day_in_week == 3 and is_leap_year $year;
}
say "";
