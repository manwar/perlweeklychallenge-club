#!perl

################################################################################
=comment

Perl Weekly Challenge 033
=========================

Task #2
-------
*Formatted Multiplication Table*

Write a script to print 11x11 multiplication table, only the top half triangle.

  x|   1   2   3   4   5   6   7   8   9  10  11
---+--------------------------------------------
  1|   1   2   3   4   5   6   7   8   9  10  11
  2|       4   6   8  10  12  14  16  18  20  22
  3|           9  12  15  18  21  24  27  30  33
  4|              16  20  24  28  32  36  40  44
  5|                  25  30  35  40  45  50  55
  6|                      36  42  48  54  60  66
  7|                          49  56  63  70  77
  8|                              64  72  80  88
  9|                                  81  90  99
 10|                                     100 110
 11|                                         121
 
=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $MAX => 11;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    # Print the multipliers

    print  '  x|';
    printf ' %3d', $_ for 1 .. $MAX;
    print   "\n";

    # Print the horizontal divider

    print  '-' x 3, '+', '-' x (4 * $MAX), "\n";

    # Print the body of the multiplication table

    for my $row (1 .. $MAX)
    {
        # Print one row: the multiplicand, followed by those products for which
        #                the multiplier does not exceed the multiplicand

        printf  '%3d|', $row;
        printf ' %3s',  $row > $_ ? '' : $row * $_ for 1 .. $MAX;
        print   "\n";
    }
}

################################################################################
