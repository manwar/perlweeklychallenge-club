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

while (<>) {
    my ($x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4) = split;
    say + ($x1 - $x2) ** 2 + ($y1 - $y2) ** 2 ==
          ($x2 - $x3) ** 2 + ($y2 - $y3) ** 2 ==
          ($x3 - $x4) ** 2 + ($y3 - $y4) ** 2 ==
          ($x4 - $x1) ** 2 + ($y4 - $y1) ** 2 &&
          ($x1 - $x3) ** 2 + ($y1 - $y3) ** 2 ==
          ($x2 - $x4) ** 2 + ($y2 - $y4) ** 2 ? 1 : 0
}
