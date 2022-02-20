#!perl

###############################################################################
=comment

Perl Weekly Challenge 152
=========================

TASK #2
-------
*Rectangle Area*

Submitted by: Mohammad S Anwar

You are given coordinates bottom-left and top-right corner of two rectangles in
a 2D plane.

Write a script to find the total area covered by the two rectangles.

Example 1:

 Input: Rectangle 1 => (-1,0), (2,2)
        Rectangle 2 => (0,-1), (4,4)

 Output: 22

Example 2:

 Input: Rectangle 1 => (-3,-1), (1,3)
        Rectangle 2 => (-1,-3), (2,2)

 Output: 25

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Command-line input is 8 real numbers: the coordinates of the bottom-left and
top-right corners, in (x, y) order, of 2 rectangles. Rectangles must have non-
zero areas. Output is the total area covered by the 2 rectangles. If the
constant $VERBOSE is set to a true value (the default), the output is followed
by an explanation.

Algorithm
---------
Consider 2 rectangles:

    +------------a1
    |             |
    |       c-----K--------b1
    |       |     |         |
    a0------J-----d         |
            |               |
            |               |
            b0--------------+

The overlapping area, rectangle cJdK, has corners (J, K) where:
    the x-coordinate of J is the larger  of a0x and b0x;
    the y-coordinate of J is the larger  of a0y and b0y;
    the x-coordinate of K is the smaller of a1x and b1x; and
    the y-coordinate of K is the smaller of a1y and b1y.

This holds true for all configurations of the 2 rectangles, provided that K is
above and to the right of J; otherwise, the rectangles do not overlap.

The combined area is the sum of the areas of the 2 rectangles less the area of
their overlap (if any).

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<c> ...]

    [<c> ...]    8 coordinates (real numbers) describing 2 rectangles\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 152, Task #2: Rectangle Area (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($a0x, $a0y, $a1x, $a1y, $b0x, $b0y, $b1x, $b1y) = parse_command_line();

    print "Input:  Rectangle 1 => ($a0x, $a0y), ($a1x, $a1y)\n";
    print "        Rectangle 2 => ($b0x, $b0y), ($b1x, $b1y)\n";

    my $area1 = ($a1x - $a0x) * ($a1y - $a0y);
    my $area2 = ($b1x - $b0x) * ($b1y - $b0y);

    # Common/shared rectangle

    my $c0x   = max( $a0x, $b0x );
    my $c0y   = max( $a0y, $b0y );
    my $c1x   = min( $a1x, $b1x );
    my $c1y   = min( $a1y, $b1y );
    my $area3 = ($c1x > $c0x &&  $c1y > $c0y) ?
                ($c1x - $c0x) * ($c1y - $c0y) : 0;

    my $total =  $area1 + $area2 - $area3;

    print "\nOutput: $total\n";

    if ($VERBOSE)
    {
        print "\nExplanation\n-----------\n",
                "The rectangles have areas of $area1 and $area2, ",
                "respectively,\n",
                "and a shared (i.e., overlapping) area of $area3\n",
                "Total area is $area1 + $area2 - $area3 = $total\n";
    }
}

#------------------------------------------------------------------------------
sub max
#------------------------------------------------------------------------------
{
    my ($p, $q) = @_;

    return $p > $q ? $p : $q;
}

#------------------------------------------------------------------------------
sub min
#------------------------------------------------------------------------------
{
    my ($p, $q) = @_;

    return $p < $q ? $p : $q;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 8 or error( "Expected 8 command line arguments, found $args" );

    my @c = @ARGV;

    for (@c)
    {
        / ^ $RE{num}{real} $ /x
            or error( qq["$_" is not a valid real number] );
    }

    $c[ 2 ] > $c[ 0 ]
        or error( "Rect 1: the right corner is not right of the left corner" );

    $c[ 3 ] > $c[ 1 ]
        or error( "Rect 1: the top corner is not above the bottom corner" );

    $c[ 6 ] > $c[ 4 ]
        or error( "Rect 2: the right corner is not right of the left corner" );

    $c[ 7 ] > $c[ 5 ]
        or error( "Rect 2: the top corner is not above the bottom corner" );

    return @c;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
