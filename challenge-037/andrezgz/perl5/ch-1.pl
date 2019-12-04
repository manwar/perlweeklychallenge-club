#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-037/
# Task #1
# Write a script to calculate the total number of weekdays (Mon-Fri) in each month of the year 2019.
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

use strict;
use warnings;

use DateTime;

my $dt = DateTime->new( year => 2019, month => 1, day => 1 );

my @weekdays;

do { $weekdays[$dt->month]++ if $dt->dow < 6; }
while ( $dt->add( days => 1 )->year < 2020 );

foreach my $m (1 .. $#weekdays){
    my $month_name = DateTime->new( year => 2019, month => $m )->month_abbr;
    printf '%4s: %d days'.$/, $month_name, $weekdays[$m] ;
}
