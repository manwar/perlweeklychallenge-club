#!/usr/bin/env perl

use 5.030;
use warnings;

sub max_points {
    my @N = @_;

    my $max_points = 0;

    for my $i (0 .. $#N-2) {
        my ($x0, $y0) = @{$N[$i]};
        for my $j ($i+1 .. $#N-1) {
            my ($x1, $y1) = @{$N[$j]};
            my $colinears = 2;
            if ($x0 == $x1) {
                $colinears += grep {$_->[0] == $x0} @N[$j+1 .. $#N];
            } else {
                my $A = ($y1 - $y0) / ($x1 - $x0);
                my $B = $y0 - $A*$x0;
                $colinears += grep {$_->[1] == $A*$_->[0] + $B} @N[$j+1 .. $#N];
            }
            $max_points = $colinears if $colinears > $max_points;
        }
    }
    return $max_points;
}

say max_points([1,1], [2,2], [3,3]);
say max_points([1,1], [2,2], [3,1], [1,3], [5,3]);
