#!/usr/bin/env perl6

# Script that prints the mean angle of a given list of
# angles in degrees.

sub MAIN (*@ang_deg where .elems > 0) {

    my constant \deg2rad = (pi/180);
    my constant \rad2deg = (180/pi);

    my $y = [+] map { ($_ * deg2rad).sin }, @ang_deg;
    my $x = [+] map { ($_ * deg2rad).cos }, @ang_deg;

    printf "Mean angle = %.2f degrees\n", (atan2($y,$x) * rad2deg);
}