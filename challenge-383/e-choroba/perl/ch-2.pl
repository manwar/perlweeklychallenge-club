#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my @WEB_SAFE = (0, 51, 102, 153, 204, 255);
sub nearest_RGB($color) {
    my ($red, $green, $blue) = map hex, $color =~ /#(..)(..)(..)/;
    my $safe = '#';
    for my $c ($red, $green, $blue) {
        my $best = 0;
        for my $s (@WEB_SAFE) {
            $best = $s if abs($c - $s) < abs($best - $c);
        }
        $safe .= sprintf '%02X', $best;
    }
    return $safe
}

use Test::More tests => 5;

is nearest_RGB('#F4B2D1'), '#FF99CC', 'Example 1';
is nearest_RGB('#15E6E5'), '#00FFCC', 'Example 2';
is nearest_RGB('#191A65'), '#003366', 'Example 3';
is nearest_RGB('#2D5A1B'), '#336633', 'Example 4';
is nearest_RGB('#00FF66'), '#00FF66', 'Example 5';
