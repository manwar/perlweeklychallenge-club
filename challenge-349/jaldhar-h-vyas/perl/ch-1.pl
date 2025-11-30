#!/usr/bin/perl
use 5.038;
use warnings;
use English;

my $str = shift;
my $maxPower = 0;

while ($str =~ /(.)\1*/g) {
    my $power = length $MATCH; ## no critic 'ProhibitMatchVars'
    if ($power > $maxPower) {
        $maxPower = $power;
    }
}

say $maxPower;
