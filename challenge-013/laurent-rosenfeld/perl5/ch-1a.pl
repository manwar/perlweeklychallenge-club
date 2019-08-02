#!/usr/bin/perl
use strict;
use warnings;
use feature "say";
use Time::Local;

sub is_leap_year {
    my $year = shift;
    return $year % 4 == 0; # works for years between 1901 and 2099
}

my @month_lengths = qw/ 31 28 31 30 31 30 31 31 30 31 30 31/;
my $year = shift // 2019;

for my $month (0..11) {
    my $month_length = $month_lengths[$month];
    $month_length = 29 if $month == 1
        and is_leap_year $year; # Feb is 1
    my @last_friday;
    for my $day (20..$month_length) {
        my $epoch = timegm(0, 0, 12, $day, $month, $year - 1900);
        my @date_details = gmtime $epoch;
        @last_friday = @date_details if $date_details[6] == 5;
    }
    printf "%d/%02d/%d\n", $year, $month + 1, $last_friday[3];
}
