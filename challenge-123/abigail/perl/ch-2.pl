#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#
# If a quadrilateral has four equal sides, it's a rhombus. 
# A rhombus in which the diagonals are equal is a square.
#
# So we check whether all edges are equal, and whether both diagonals are equal.
#

#
# Given the coordinates of two points, return the square of
# the distance between them.
#
sub dist ($x1, $y1, $x2, $y2) {($x1 - $x2) ** 2 + ($y1 - $y2) ** 2}

while (<>) {
    my  ($x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4) = split;
    say dist ($x1, $y1, $x2, $y2) == dist ($x2, $y2, $x3, $y3) ==
        dist ($x3, $y3, $x4, $y4) == dist ($x4, $y4, $x1, $x2) &&
        dist ($x1, $y1, $x3, $y3) == dist ($x2, $y2, $x4, $y4) ? 1 : 0
}
