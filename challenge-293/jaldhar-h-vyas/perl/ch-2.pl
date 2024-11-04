#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

sub isBoomerang(@points) {
    my ($x1, $y1) = @{$points[0]};
    my ($x2, $y2) = @{$points[1]};
    my ($x3, $y3) = @{$points[2]};

    if (
        ($x1 == $x2 && $y1 == $y2) ||
        ($x1 == $x3 && $y1 == $y3) ||
        ($x2 == $x3 && $y2 == $y3)
    ) {
        return false;
    }

    my $area = $x1 * ($y2 - $y3) + $x2 * ($y3 - $y1) + $x3 * ($y1 - $y2);
    return $area != 0;
}

my @points = map { [split q{ }] } @ARGV;
say isBoomerang(@points) ? 'true' : 'false';
