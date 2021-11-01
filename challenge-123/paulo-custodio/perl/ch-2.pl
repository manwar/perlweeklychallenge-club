#!/usr/bin/env perl

# TASK #2 > Square Points
# Submitted by: Mohammad S Anwar
# You are given coordinates of four points i.e.
# (x1, y1), (x2, y2), (x3, y3) and (x4, y4).
#
# Write a script to find out if the given four points form a square.
#
# Example
# Input: x1 = 10, y1 = 20
#        x2 = 20, y2 = 20
#        x3 = 20, y3 = 10
#        x4 = 10, y4 = 10
# Output: 1 as the given coordinates form a square.
#
# Input: x1 = 12, y1 = 24
#        x2 = 16, y2 = 10
#        x3 = 20, y3 = 12
#        x4 = 18, y4 = 16
# Output: 0 as the given coordinates doesn't form a square.

use Modern::Perl;

# point object
{
    package Point;
    use Object::Tiny::RW qw( x y );

    sub new {
        my($class, $x, $y) = @_;
        return bless {x=>$x, y=>$y}, $class;
    }
}

# square of distance between two points
sub dist_sq {
    my($p, $q) = @_;
    return ($p->x - $q->x) * ($p->x - $q->x) +
           ($p->y - $q->y) * ($p->y - $q->y)
}

# check if four points form a square
sub is_square {
    my($p1, $p2, $p3, $p4) = @_;

    my $d2 = dist_sq($p1, $p2);
    my $d3 = dist_sq($p1, $p3);
    my $d4 = dist_sq($p1, $p4);

    return 0 if $d2 == 0 || $d3 == 0 || $d4 == 0;

    return 1 if $d2 == $d3 && 2 * $d2 == $d4 &&
                2 * dist_sq($p2, $p4) == dist_sq($p2, $p3);
    return 1 if $d3 == $d4 && 2 * $d3 == $d2 &&
                2 * dist_sq($p3, $p2) == dist_sq($p3, $p4);
    return 1 if $d2 == $d4 && 2 * $d2 == $d3 &&
                2 * dist_sq($p2, $p3) == dist_sq($p2, $p4);
    return 0;
}

my $p1 = Point->new(splice(@ARGV, 0, 2));
my $p2 = Point->new(splice(@ARGV, 0, 2));
my $p3 = Point->new(splice(@ARGV, 0, 2));
my $p4 = Point->new(splice(@ARGV, 0, 2));

say is_square($p1, $p2, $p3, $p4);
