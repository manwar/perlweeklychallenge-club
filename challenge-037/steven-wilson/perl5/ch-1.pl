#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-12-02
# Week: 037
# Task #1
# Write a script to calculate the total number of weekdays (Mon-Fri) in
# each month of the year 2019.

use strict;
use warnings;
use feature qw/ say /;
use DateTime;

my @months = qw/ Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec /;
my $year = "2019";
my %weekdays_in_month;
my $dt = DateTime->new( year => $year );

while ( $dt->year eq $year ) {
    if ( $dt->dow() < 6 ) {
        $weekdays_in_month{ $dt->month_abbr() }++;
    }
    $dt->add( days => 1 );
}

for my $month (@months) {
    say "$month: $weekdays_in_month{$month}";
}
