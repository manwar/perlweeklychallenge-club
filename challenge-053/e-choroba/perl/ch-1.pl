#!/usr/bin/perl
use warnings;
use strict;

use PDL;

my $matrix = pdl([1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9]);

for my $rotation (0, 90, 180, 270) {
    my $times = $rotation / 90;
    my $result = $matrix;
    $result = $result->transpose->slice([-1, 0]) for 1 .. $times;
    print "$rotation:$result";
}
