#! /usr/bin/perl

use strict;
use warnings;
use feature qw(say);

my @points = (  [0,1],
                [2,0],
                [-6,0]
             );

sub is_origin_in {
    my (@p,$x) = @{+pop};
    my $m = $p[0][1] * $p[2][0] - $p[0][0] * $p[2][1];
    my $n = $p[0][0] * $p[1][1] - $p[0][1] * $p[1][0];

    return (($m < 0) != ($n < 0)) ?
        0:
        ( $x = $p[1][0] * $p[2][1] - $p[1][1] * $p[2][0] + $p[0][1] * ($p[2][0] - $p[1][0]) + $p[0][0] * ($p[1][1] - $p[2][1])) < 0 ? 
            ($m <= 0 && $m + $n >= $x) :
            ($m >= 0 && $m + $n <= $x);
}

say is_origin_in (\@points)