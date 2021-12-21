#!/usr/bin/perl

# Challenge 030
#
# Task #1
# Write a script to list dates for Sunday Christmas between 2019 and 2100. For
# example, 25 Dec 2022 is Sunday.

use Modern::Perl;
use DateTime;

my @sunday_xmas;
for my $year (2019..2100) {
    my $date = DateTime->new(year=>$year, month=>12, day=>25);
    push @sunday_xmas, $year if $date->day_of_week == 7;
}

say join(", ", @sunday_xmas);
