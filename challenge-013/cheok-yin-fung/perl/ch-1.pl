#!/usr/bin/perl
# The Weekly Challenge - 013
# Task 1 Last Friday
# attempt: May 09th, 2021
# from: C.-Y. Fung
# Usage: ch-1.pl [year]
# Java correspondence: LastFriday.java
use Time::Piece;
use Time::Seconds;
use strict;
use warnings;

my $year = $ARGV[0] || 2008;
die "Sorry, it's too long ago." if $year < 1900;
print "Year: $year\n\n";

for my $month (1..12) { 
    my $first_day_of_nmonth = ($month != 12) ? 
         Time::Piece->strptime($year."-".($month+1)."-01", "%Y-%m-%d")
       : Time::Piece->strptime(($year+1)."-01-01", "%Y-%m-%d");

    my $target_day = ($first_day_of_nmonth -= ONE_DAY);
    while ($target_day->day_of_week != 5) {
        $target_day -= ONE_DAY;
    }
    print($target_day->strftime("%Y-%m-%d"), "\n");
}
