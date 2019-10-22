#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Write a script to list dates for Sunday Christmas between 2019 and 2100.
# For example, 25 Dec 2022 is Sunday.

# Christmas Day is always Dec 25.

use DateTime;

for my $year ( 2019 .. 2100 ) {
    my $dt = DateTime->new(
        year      => $year,
        month     => 12,
        day       => 25,
        hour      => 12,
        minute    => 0,
        second    => 0,
        time_zone => 'floating'
    );
    if ( 6 == $dt->day_of_week_0() ) { say $dt->date }
}

__DATA__

2022-12-25
2033-12-25
2039-12-25
2044-12-25
2050-12-25
2061-12-25
2067-12-25
2072-12-25
2078-12-25
2089-12-25
