use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 123
=========================

TASK #2
-------
*Square Points*

Submitted by: Mohammad S Anwar

You are given coordinates of four points i.e. (x1, y1), (x2, y2), (x3, y3) and
(x4, y4).

Write a script to find out if the given four points form a square.

Example

 Input: x1 = 10, y1 = 20
        x2 = 20, y2 = 20
        x3 = 20, y3 = 10
        x4 = 10, y4 = 10
 Output: 1 as the given coordinates form a square.

 Input: x1 = 12, y1 = 24
        x2 = 16, y2 = 10
        x3 = 20, y3 = 12
        x4 = 18, y4 = 16
 Output: 0 as the given coordinates doesn't form a square.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
(1) A square must have non-zero area, so four identical points do not form a
    square
(2) The requirement "find out if the given four points form a square" means
    "determine whether the quadrilateral having these four points as its four
    *corners* is a square"

Algorithm
---------
A square has 4 sides of identical length, but a quadrilateral with 4 sides of
identical length is a rhombus, not necessarily a square. For it to be a square,
its interior angles must be all equal (viz., right angles).

However, measuring angles is a more complex task than measuring lengths, so the
method adopted below makes use of the additional property that the interior
diagonals joining opposite corners of a square are equal, and each is √2 times
the length of any exterior side.

Distances between points on the Cartesian plane are calculated using the
Pythagorean theorem.

=end comment
#==============================================================================

my Real constant $EPSILON = 1e-9;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 123, Task #2: Square Points (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| Cartesian coordinates x1, y1, x2, y2, x3, y3, x4, y4

    *@coords where { @coords.elems == 8 && .all ~~ Real:D }
)
#==============================================================================
{
    ("Input:  x1 = @coords[ 0 ], y1 = @coords[ 1 ]\n" ~
     "        x2 = @coords[ 2 ], y2 = @coords[ 3 ]\n" ~
     "        x3 = @coords[ 4 ], y3 = @coords[ 5 ]\n" ~
     "        x4 = @coords[ 6 ], y4 = @coords[ 7 ]").put;

    my Real @dists;

    # Let the 4 points be a, b, c, d; here we calculate the 6 distances ab, ac,
    # ad, bc, bd, cd

    for [ 0 .. 3 ], [ 0, 1, 4, 5 ], [ 0, 1, 6, 7 ],
        [ 2 .. 5 ], [ 2, 3, 6, 7 ], [ 4   ..   7 ] -> List $slice
    {
        @dists.push: distance( |@coords[ |$slice ] );
    }

    # If the 4 given points do describe a square, then sorting the distances in
    # ascending numerical order ensures that the first 4 array elements are the
    # lengths of the exterior sides and the last two are the lengths of the
    # interior diagonals

    @dists .= sort;

    # Strictly, only 1 of the final 2 tests is needed; the second is provided
    # as a sanity check

    my Bool $is-square = !equals( @dists[ 0 ], 0           ) &&
                          equals( @dists[ 0 ], @dists[ 1 ] ) &&
                          equals( @dists[ 1 ], @dists[ 2 ] ) &&
                          equals( @dists[ 2 ], @dists[ 3 ] ) &&
                          equals( @dists[ 4 ], @dists[ 5 ] ) &&
                          equals( @dists[ 4 ], @dists[ 0 ] * sqrt( 2 ) );

    "Output: %d\n".printf: $is-square ?? 1 !! 0;
}

#------------------------------------------------------------------------------
sub distance( Real:D $x1, Real:D $y1, Real:D $x2, Real:D $y2 --> Real:D )
#------------------------------------------------------------------------------
{
    # Apply the Pythagorean theorem

    return sqrt( ($x2 - $x1) ** 2 + ($y2 - $y1) ** 2 );
}

#------------------------------------------------------------------------------
sub equals( Real:D $x, Real:D $y --> Bool:D )
#------------------------------------------------------------------------------
{
    # Determine equality between real (i.e., floating point) numbers

    return abs( $x - $y ) < $EPSILON;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
