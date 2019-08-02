#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-30
# Week: 019
#
# Task #1
# Write a script to display months from the year 1900 to 2019 where you
# find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

use strict;
use warnings;
use DateTime;
use feature qw/ say /;

# If there are 31 days in a month and the first day of the month is a Friday
# then there are 5 weekends in a month.

my $dt = DateTime->new(
    year  => 1900,
    month => 1,
    day   => 1,
);

while ( $dt->year() < 2020 ) {
    if ( $dt->month_length() == 31 && $dt->dow() == 5 ) {
        say $dt->year() . " " . $dt->month_name();
    }
    $dt->add( months => 1 );
}

