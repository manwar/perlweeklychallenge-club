#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-037/
# Task #2
# Write a script to find out the DayLight gain/loss in the month of December 2019
# as compared to November 2019 in the city of London.
# You can find out sunrise and sunset data for November 2019 and December 2019 for London.
# https://www.timeanddate.com/sun/uk/london?month=11&year=2019
# https://www.timeanddate.com/sun/uk/london?month=12&year=2019

use strict;
use warnings;

my $diff = daylight('december.csv') - daylight('november.csv');
print 'The daylight difference is ', int $diff/60, ':', abs($diff) % 60, $/;

# Modulo operator works funny with negative numbers, that's why I've used abs
# -1280 % 60 = 40 (not -20)
# With use integer you get proper and fast libc behavior.
# See https://stackoverflow.com/a/32090446 for more detail

sub daylight {
    my $fn = shift;
    my $daylight = 0;
    open my $fh, '<', $fn or die "Could not open file '$fn': $!";

    while (<$fh>) {
        chomp;
        my ($sunrise_h, $sunrise_m, $sunset_h, $sunset_m) = split /[:;]/;
        $daylight += ($sunset_h - $sunrise_h) * 60 + ($sunset_m - $sunrise_m);
    }

    close $fh;
    return $daylight;
}

__END__

./ch-2.pl
The daylight difference is -21:20 <--- almost a day!
