#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

use DateTime;

# This table shows how this will work for any given year
#
# dow  => day of week (numerical)
# leap => is a leap year (bool)
# woy  => week of year (1, 52, 53)
#
#      dow     leap    woy      day
#   ---------------------------------------
#       1       0       1       Monday
#       1       1       1       Monday
#       2       0       1       Tuesday
#       2       1       1       Tuesday
#       3       0       1       Wednesday
#       3       1       1       Wednesday
#       4       0       53      Thursday
#       4       1       53      Thursday
#       5       0       52      Friday
#       5       1       53      Friday
#       6       0       52      Saturday
#       6       1       52      Saturday
#       7       0       52      Sunday
#       7       1       52      Sunday

my @years;
for my $year ( 1900 .. 2100 ) {
    my $dt = DateTime->new(
        month => 12,
        day   => 31,
        year  => $year,
    );
    my ( undef, $week_of_year ) = $dt->week;
    my $dow     = $dt->day_of_week;
    my $nam     = $dt->day_name;
    my $is_leap = $dt->is_leap_year;
    push @years, $year if $week_of_year == 53;
}

my @x;
while (@years) {
    push @x, shift @years;
    if ( scalar @x == 5 ) {
        say join ', ', @x, '';
        @x = ();
    }
}

say join ', ', @x;
