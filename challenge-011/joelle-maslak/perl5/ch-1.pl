#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

MAIN: {
    # We could solve this algebraicly, but what fun is that?

    my $temp =   0; # Start at 0F
    my $step = 100; # Do 100 degree increments initially

    while (abs($temp - f2c($temp)) > .001) {
        $step /= 2 if abs($temp - f2c($temp)) < $step;

        if ($temp > f2c($temp)) {
            $temp -= $step;
        } else {
            $temp += $step;
        }
    }

    say sprintf("%.0f", $temp);
}

sub f2c($f) {
    return ($f - 32) * (100 / (212 - 32));
}

