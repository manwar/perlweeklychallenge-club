use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 101
=========================

Task #2
-------
*Origin-containing Triangle*

Submitted by: Stuart Little

You are given three points in the plane, as a list of six co-ordinates:
A=(x1,y1), B=(x2,y2) and C=(x3,y3).

Write a script to find out if the triangle formed by the given three co-
ordinates contain origin (0,0).

Print 1 if found otherwise 0.

Example 1:

 Input: A=(0,1), B=(1,0) and C=(2,2)

 Output: 0 because that triangle does not contain (0,0).

Example 2:

 Input: A=(1,1), B=(-1,1) and C=(0,-3)

 Output: 1 because that triangle contains (0,0) in its interior.

Example 3:

 Input: A=(0,1), B=(2,0) and C=(-6,0)

 Output: 1 because (0,0) is on the edge connecting B and C.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

The algorithm in subroutine collinear() is adapted from:

    Eric W. Weisstein, "Collinear". MathWorld--A Wolfram Web Resource:
    https://mathworld.wolfram.com/Collinear.html

The algorithm in subroutine point-in-triangle() is adapted from:

   "1st method: barycentric coordinate system"
    in Cédric Jules, "Accurate point in triangle test". Totologic blog:
    http://totologic.blogspot.com/2014/01/accurate-point-in-triangle-test.html

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

subset Point of List where (Real, Real);

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 101, Task #2: Origin-containing Triangle (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| X-Y co-ordinates of the 3 vertices of a triangle
    *@coords where { @coords.elems == 6 && .all ~~ Real:D }
)
#==============================================================================
{
    my Point $A = [ @coords[ 0 ].Real, @coords[ 1 ].Real ];
    my Point $B = [ @coords[ 2 ].Real, @coords[ 3 ].Real ];
    my Point $C = [ @coords[ 4 ].Real, @coords[ 5 ].Real ];

    # The 3 points defining a triangle must be distinct, and not collinear

    error( 'Identical points' ) if $A eq $B || $A eq $C || $B eq $C;
    error( 'Collinear points' ) if collinear( $A, $B, $C );

    "Input:  A=($A[0],$A[1]), B=($B[0],$B[1]) and C=($C[0],$C[1])\n".put;

    my (Bool $result, Str $explanation) = contains-origin( $A, $B, $C );

    "Output: %d%s\n".printf: $result  ?? 1 !! 0,
                             $VERBOSE ?? ' because ' ~ $explanation !! '';
}

#------------------------------------------------------------------------------
sub contains-origin
(
    Point:D $A,
    Point:D $B,
    Point:D $C,
--> List:D[Bool:D, Str:D]
)
#------------------------------------------------------------------------------
{
    for $A, $B, $C -> Point $point
    {
        return True, '(0,0) is a vertex of the triangle'
            if $point[0] == 0 && $point[1] == 0;
    }

    my Point $origin = [ 0, 0 ];

    return True,  '(0,0) is on the edge connecting A and B'
        if collinear( $A, $B, $origin );

    return True,  '(0,0) is on the edge connecting A and C'
        if collinear( $A, $C, $origin );
    
    return True,  '(0,0) is on the edge connecting B and C'
        if collinear( $B, $C, $origin );

    return True,  'that triangle contains (0,0) in its interior'
        if point-in-triangle( $A, $B, $C );

    return False, 'that triangle does not contain (0,0)';
}

#------------------------------------------------------------------------------
sub point-in-triangle( Point:D $A, Point:D $B, Point:D $C --> Bool:D )
#------------------------------------------------------------------------------
{
    my Real $d = ($B[1] - $C[1]) * ($A[0] - $C[0]) +
                 ($C[0] - $B[0]) * ($A[1] - $C[1]);

    my Real $x = (($B[1] - $C[1]) * -$C[0] + ($C[0] - $B[0]) * -$C[1]) / $d;

    my Real $y = (($C[1] - $A[1]) * -$C[0] + ($A[0] - $C[0]) * -$C[1]) / $d;

    my Real $z = 1 - $x - $y;

    return 0 <= $x <= 1 &&
           0 <= $y <= 1 &&
           0 <= $z <= 1;
}

#------------------------------------------------------------------------------
sub collinear( Point:D $A, Point:D $B, Point:D $C --> Bool:D )
#------------------------------------------------------------------------------
{
    return $A[0] * ($B[1] - $C[1]) +
           $B[0] * ($C[1] - $A[1]) +
           $C[0] * ($A[1] - $B[1]) == 0;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit;
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
