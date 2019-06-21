#!/usr/bin/perl -w
use strict;
use feature 'say';
use DateTime;


my $year = 2019;

for my $month (1..12) {
    my $dt = DateTime->last_day_of_month( year => $year, month => $month );
    $dt->subtract( days => (2 + $dt->dow)%7 );
    say $dt->ymd('/');
}
