#!/usr/bin/env perl6
use v6;

sub MAIN() {
    # We could solve this algebraicly but what fun is that?

    my $temp =   0; # Start at 0F
    my $step = 100; # Do 100 degree increments initially

    while ($temp - f2c($temp)).abs > .001 {
        $step /= 2 if ($temp - f2c($temp)).abs < $step;

        if $temp > f2c($temp) {
            $temp -= $step;
        } else {
            $temp += $step;
        }
    }

    say $temp.round;  # We're happy getting this within 1 degree
}

sub f2c($f) {
    return ($f - 32) * (100 / (212 - 32));
}


