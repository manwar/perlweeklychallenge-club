#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Time::Local;

my $yr = shift // 2019;
my @months = (0, 31, is_leap($yr) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
my $start_date = timegm( 0, 0, 0, 1, 0, $yr - 1900 ); # Jan 1st
my $day_in_week = (gmtime $start_date)[6];

for my $month (1..12) {
    my $weekdays = 20;
    for my $day (29..$months[$month]) {
        $weekdays ++ unless $day_in_week =~ /[607]/;
        $day_in_week ++;
    }
    printf "%02d/%d has  $weekdays week days.\n", $month, $yr;
    $day_in_week -= 7 if  $day_in_week > 6;
}

sub is_leap {
    my $yr = shift;
    return 0 if $yr % 4;    # no if not divisible by 4
    return 1 if $yr % 100;  # yes if divisible by 4 but not by 100
    return 0 if $yr % 400;  # no if divisible by 100 and not by 400
    return 1;               # yes if divisibe by 400
}
