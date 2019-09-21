#!/usr/bin/perl

use v5.16;
use strict;
use warnings;

my $x = my $y = 0;

for my $angle (@ARGV) {
    my $rad = ($angle % 360.0) * 3.14159 / 180.0;
    $x += cos($rad);
    $y += sin($rad);
}

if (abs($x) < .00001 and abs($y) < .00001) {
    say "No average";
} else {
    my $deg = atan2($y,$x) * 180 / 3.14159;
    if ($x > 0 and $y > 0) {
        printf("%.2f\n", $deg);
    } elsif ($x < 0 and $y > 0) {
        printf("%.2f\n", $deg);
    } elsif ($x < 0 and $y < 0) {
        printf("%.2f\n", $deg + 360);
    } else {
        my $out = sprintf("%.2f", ($deg + 360));
        if ($out eq '360.00') {
            say "0.00";
        } else {
            say $out;
        }
    }
}


