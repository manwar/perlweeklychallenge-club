#!/usr/bin/env raku

use Test;
plan 9;

my @tests = '03:10', 35,
            '04:00', 120,
            '09:20', 160,
            '09:40', 50,
            '10:45', 52.5,
            '10:55', 2.5,
            '12:00', 0,
            '11:59', 5.5,
            '12:01', 5.5;

for @tests -> $a, $b 
{
    is clock-angle($a), $b
}

sub clock-angle($T) 
{
    my ($h, $m) = $T.split(':');

    my $angle = abs($h * 30 + $m / 2 - $m * 6);

    min($angle, 360 - $angle);
}
