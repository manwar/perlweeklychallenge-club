use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Command-line input is 8 real numbers: the coordinates of the bottom-left and
top-right corners, in (x, y) order, of 2 rectangles. Rectangles must have non-
zero areas. Output is the total area covered by the 2 rectangles. If the
constant $VERBOSE is set to True (the default), the output is followed by an
explanation.

Note re: the Windows command prompt:

If the first number on the command line is negative, the minus sign will be
interpreted as a command-line flag, resulting in a "Usage" error. To enter a
negative number as the first argument, precede the arguments with a double
hyphen:

    raku ch-2.raku -- -1 0 2 2 0 -1 4 4

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

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

subset Coord of Real;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 152, Task #2: Rectangle Area (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| 8 coordinates (real numbers) describing 2 rectangles

    *@c where { .elems == 8 && .all ~~ Coord:D &&
                @c[ 2 ] > @c[ 0 ] && @c[ 3 ] > @c[ 1 ] &&
                @c[ 6 ] > @c[ 4 ] && @c[ 7 ] > @c[ 5 ] }
)
#==============================================================================
{
    my Coord ($a0x, $a0y, $a1x, $a1y, $b0x, $b0y, $b1x, $b1y) = @c;

    "Input:  Rectangle 1 => ($a0x, $a0y), ($a1x, $a1y)".put;
    "        Rectangle 2 => ($b0x, $b0y), ($b1x, $b1y)".put;

    my Coord $area1 = ($a1x - $a0x) * ($a1y - $a0y);
    my Coord $area2 = ($b1x - $b0x) * ($b1y - $b0y);

    # Common/shared rectangle

    my Coord $c0x   = ($a0x, $b0x).max;
    my Coord $c0y   = ($a0y, $b0y).max;
    my Coord $c1x   = ($a1x, $b1x).min;
    my Coord $c1y   = ($a1y, $b1y).min;
    my Coord $area3 = ($c1x > $c0x &&  $c1y > $c0y) ??
                      ($c1x - $c0x) * ($c1y - $c0y) !! 0;

    my Coord $total =  $area1 + $area2 - $area3;

    "\nOutput: $total".put;

    if $VERBOSE
    {
        "\nExplanation\n-----------".put;
        "The rectangles have areas of $area1 and $area2, respectively,".put;
        "and a shared (i.e., overlapping) area of $area3".put;
        "Total area is $area1 + $area2 - $area3 = $total".put;
    }
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
