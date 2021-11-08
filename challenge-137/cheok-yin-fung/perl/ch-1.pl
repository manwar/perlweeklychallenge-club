#!/usr/bin/perl
# The Weekly Challenge 137
# Task 1 Long Year
# Usage: ch-1.pl
use v5.12.0;
use warnings;
use Time::Local qw 'timegm_nocheck';

my $c = 0;
for my $y (1900..2100) {
    my %wday = (
        "Mon" => 1, 
        "Tue" => 2, 
        "Wed" => 3, 
        "Thu" => 4, 
        "Fri" => 5, 
        "Sat" => 6, 
        "Sun" => 7, 
    );

    my $fourthJan = localtime timegm_nocheck 0, 0, 0, 4, 0, $y;

    my $a = $wday{(split " ", $fourthJan)[0]};

    my $yearLastDay = localtime timegm_nocheck 0, 0, 0, 31, 11, $y;

    my $b = $wday{(split " ", $yearLastDay)[0]};

    if ($a >= 4 && $b >= 4) {
        say $y;
        $c++;
    }
}

say "Number of Long Years: $c";
