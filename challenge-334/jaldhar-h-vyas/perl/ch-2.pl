#!/usr/bin/perl
use 5.038;
use warnings;

sub manhattanDistance($x, $y, $x1, $y1) {
    return abs($x1 - $x) + abs($y1 - $y);
}

my ($x, $y, @points) = @ARGV;
my $smallestDistance = 'Inf';
my $smallestPoint = -1;

for my $point (keys @points) {
    my ($x1, $y1) = split /,/, $points[$point];

    if ($x1 == $x || $y1 == $y) {
        my $distance = manhattanDistance($x, $y, $x1, $y1);

        if ($distance < $smallestDistance) {
            $smallestDistance = $distance;
            $smallestPoint = $point;
        }
    }
}

say $smallestPoint;
