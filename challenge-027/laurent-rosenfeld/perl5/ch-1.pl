#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub find_line {
    my ($x1, $y1, $x2, $y2) = @_;
    my $slope = ($y2 - $y1) / ($x2 - $x1);
    # find b for y1 = slope * x1 + b
    my $b = $y1 - $slope * $x1;
    return $slope, $b;
}

sub find_intersect {
    my ($a1, $b1, $a2, $b2) = @_;
    # solve y = ax + b for a1, b1 and a2, b2
    # i.e.: a1 x + b1 = a2 x + b2 <=> x (a1 - a2) = b2 - b1
    die "The segments are parallel or colinear, no intersection point!" if ($a1 == $a2);
    my $abscissa = ($b2 - $b1) / ($a1 - $a2);
    say "x = $abscissa";
    my $ordinate = $a1 * $abscissa + $b1;
    return $abscissa, $ordinate;
}
my ($a1, $b1, $a2, $b2);
if (@ARGV == 8) {
    die "The two segments are vertical, no intersection point"
        if $ARGV[0] == $ARGV[2] and $ARGV[4] == $ARGV[6];
    if ($ARGV[0] == $ARGV[2]) {
        #First segment is vertical
        my $abscissa = $ARGV[0];
        ($a2, $b2) = find_line @ARGV[4..7];
        my $ordinate = $a2 * $abscissa + $b2;
        say "Intersection point: $abscissa, $ordinate";
        exit 0;
    }
    if ($ARGV[4] == $ARGV[6]) {
        # Second segment is vertical
        my $abscissa = $ARGV[4];
        ($a1, $b1) = find_line @ARGV[0..3];
        my $ordinate = $a1 * $abscissa + $b1;
        say "Intersection point: $abscissa, $ordinate";
        exit 0;
    }
    ($a1, $b1) = find_line @ARGV[0..3];
    ($a2, $b2) = find_line @ARGV[4..7];
} else {
    # default test values if arguments are missing or insufficient
    ($a1, $b1) = find_line 3, 1, 5, 3;
    ($a2, $b2) = find_line 3, 3, 6, 0;
}
say "a1: $a1";
say "b1: $b1";
say "a2: $a2";
say "b2: $b2";

my ($x, $y) = find_intersect ($a1, $b1, $a2, $b2);
say "Intersection point abscissa: $x";
say "Intersection point ordinate: $y";
