#!/usr/bin/env perl
#
# Write a script to display months from the year 1900 to 2019 where you find 5
# weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.
################################################################################

use strict;
use warnings;

use DateTime;

my @months;
for my $year (1900 .. 2019) {
    for my $month (1 .. 12) {
        my $date = DateTime->last_day_of_month(year => $year, month => $month);
        my $day = $date->day;
        my $dow = $date->day_of_week();
        push @months, $date->strftime("%m/%Y")
            if $day == 30 && $dow == 7 || $day == 31 && ($dow == 7 || $dow == 1);
    }
}

print "Months with 5 weekends: @months\n"
