#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-14
# Week: 030

# Task #1
# Write a script to list dates for Sunday Christmas between 2019 and
# 2100. For example, 25 Dec 2022 is Sunday.

use strict;
use warnings;
use feature qw/ say /;
use DateTime;

my $start_year = 2019;
my $end_year   = 2100;
my $sunday     = 7;
my $dt         = DateTime->new(
    year  => $start_year,
    month => 12,
    day   => 25
);
my @sunday_christmas;

while ( $dt->year() <= $end_year ) {
    if ( $dt->dow() == $sunday ) {
        push @sunday_christmas, $dt->clone();
    }
    $dt->add( years => 1 );
}

say "List of Sunday Christmases between $start_year and $end_year:";
say join "\n", @sunday_christmas;
