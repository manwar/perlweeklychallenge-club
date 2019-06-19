#!/usr/bin/perl
use strict;
use warnings;
use feature "say";
use Time::Local qw/timegm_nocheck/ ;


my $year = shift // 2019;
for my $month (0..11) {
    my @last_friday;
    for my $day (20..31) {
        my $epoch =
            timegm_nocheck(0, 0, 12, $day, $month, $year - 1900);
        my @date_details = gmtime $epoch;
        last if $date_details[3] != $day;
        @last_friday = @date_details if $date_details[6] == 5;
    }
    printf "%d/%02d/%d\n", $year, $month + 1, $last_friday[3];
}
