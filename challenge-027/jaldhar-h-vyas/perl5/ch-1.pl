#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub intersection {
    my ($a, $b, $c, $d, $p, $q, $r, $s) = @_;

    my $denominator = ((($c - $a) * ($s - $q)) - (($r - $p) * ($d - $b)));

    if ($denominator == 0) {
        say 'Lines do not intersect or intersect at multiple points.';
        return;
    }

    my $x = ((($c * $b) - ($a * $d)) * ($r - $p)) -
        ((($r * $q) - ($p * $s)) * ($c - $a)) /
        $denominator;

    my $y = ((($c * $b) - ($a * $d)) * ($s - $q)) -
        ((($r * $q) - ($p * $s)) * ($d - $b)) /
        $denominator;

    say "($x,$y)";
}

if (scalar @ARGV != 8) {
    say 'specify four points as integers: x1 y1 x2 y2 x3 y3 x4 y4';
} else {
    intersection(@ARGV);
}