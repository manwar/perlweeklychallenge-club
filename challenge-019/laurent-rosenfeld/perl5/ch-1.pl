#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Time::Local;

for my $year (0..119) {
    for my $month ( 1, 3, 5, 7, 8, 10, 12) {
        my $date = timegm (0, 0, 0, 1, $month - 1, $year);
        say $year + 1900, "-", sprintf("%02d ", $month)
            if (gmtime $date)[6] == 5;
    }
}
