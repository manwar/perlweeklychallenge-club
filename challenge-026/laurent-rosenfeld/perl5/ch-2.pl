#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use constant PI => atan2(1, 0) * 2;
use Test::More;
plan tests => 9;


sub deg2rad { return $_[0] * PI /180; }
sub rad2deg { return $_[0] * 180 / PI }

sub mean {
    my @angles = map { deg2rad $_ } @_;
    my $count = @angles;
    my ($sum_sin, $sum_cos) = (0, 0);
    for my $angle (@angles) {
        $sum_sin += sin $angle;
        $sum_cos += cos $angle;
    }
    return rad2deg atan2 $sum_sin/$count, $sum_cos/$count;
}

is deg2rad(0), 0, "To rad: 0 degree";
is deg2rad(90), PI/2, "To rad: 90 degrees";
is deg2rad(180), PI, "To rad: 180 degrees";
is rad2deg(PI/2), 90, "To degrees: 90 degrees";
is rad2deg(PI), 180, "To degrees: 180 degrees";
is deg2rad(rad2deg(PI)), PI, "Roundtrip rad -> deg -> rad";
is rad2deg(deg2rad(90)), 90, "Roundtrip deg -> rad -> deg";
is mean(10, 20, 30), 20, "Mean of 10, 20, 30 degrees";
is mean(355, 5, 15), 5, "Mean of 355, 5, 15 degrees";
