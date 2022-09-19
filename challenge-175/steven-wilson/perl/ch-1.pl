#!/usr/bin/env perl
# Week 175 Task 1
# Write a script to list Last Sunday of every month in the given year.

use strict;
use warnings;
use DateTime;

my $year = $ARGV[0];
my $dt   = DateTime->new( year => $year, month => 1, day => 1 );
my %sundays;

while ( $year == $dt->year ) {
    if ( $dt->dow == 7 ) {
        $sundays{ $dt->mon } = $dt->day;
        $dt->add( days => 7 );
    }
    else {
        $dt->add( days => 1 );
    }
}

for my $month ( sort { $a <=> $b } keys %sundays ) {
    printf( "$year-%02d-$sundays{$month}\n", $month );
}
