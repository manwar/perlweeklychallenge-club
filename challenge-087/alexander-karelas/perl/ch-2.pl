#!/usr/bin/env perl

use v5.30;
use warnings;

my @A = (
    [qw/ 0 1 0 1 0 1 /],
    [qw/ 1 0 1 0 1 0 /],
    [qw/ 0 1 0 1 0 1 /],
    [qw/ 1 0 1 0 1 0 /],
);

my $height = @A;
my $width = @{$A[0]};

my $max_solution = [0, 0];

for (my $y0 = 0; $y0 < $height; $y0++) {
    for (my $x0 = 0; $x0 < $width; $x0++) {
        for (my $y1 = $y0 + 1; $y1 < $height; $y1++) {
            X1: for (my $x1 = $x0 + 1; $x1 < $width; $x1++) {
                for (my $sy = $y0; $sy <= $y1; $sy++) {
                    for (my $sx = $x0; $sx <= $x1; $sx++) {
                        if ($A[$sy][$sx] != 1) {
                            next X1;
                        }
                    }
                }
                my $area = ($y1 - $y0 + 1) * ($x1 - $x0 + 1);
                if ($area > $max_solution->[0] * $max_solution->[1]) {
                    $max_solution = [$y1 - $y0 + 1, $x1 - $x0 + 1];
                }
            }
        }
    }
}

if ($max_solution->[0] == 0) {
    print "0\n";
} else {
    for (1 .. $max_solution->[0]) {
        print "[ ", join(" ", (1) x $max_solution->[1]), " ]\n";
    }
}
