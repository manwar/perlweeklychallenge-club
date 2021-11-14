#!/usr/bin/perl
# The Weekly Challenge 137
# Task 1 Long Year
# Usage: ch-1.pl
# modified: 14th Nov 2021
use v5.12.0;
use warnings;
use Time::gmtime;
use Time::Local qw 'timegm_nocheck';


my $c = 0;

for my $y (1900..2100) {

    my $fourthJan = gmtime timegm_nocheck 0, 0, 0, 4, 0, $y;

    my $a = $fourthJan->wday();

    my $yearLastDay = gmtime timegm_nocheck 0, 0, 0, 31, 11, $y;

    my $b = $yearLastDay->wday();

    if (($a >= 4 || $a == 0) && ($b >= 4 || $b == 0)) {
        say $y;
        $c++;
    }
}

say "Number of Long Years: $c";
