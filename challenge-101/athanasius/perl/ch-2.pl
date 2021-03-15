#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The algorithm in subroutine collinear() is adapted from:

    Eric W. Weisstein, "Collinear". MathWorld--A Wolfram Web Resource:
    https://mathworld.wolfram.com/Collinear.html

The algorithm in subroutine point_in_triangle() is adapted from:

   "1st method: barycentric coordinate system"
    in Cédric Jules, "Accurate point in triangle test". Totologic blog:
    http://totologic.blogspot.com/2014/01/accurate-point-in-triangle-test.html

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<coords> ...]

    [<coords> ...]    X-Y co-ordinates of the 3 vertices of a triangle\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 101, Task #2: Origin-containing Triangle (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($A, $B, $C) = parse_command_line();

    print 'Input:  A=(', $A->[ 0 ], ',', $A->[ 1 ],
               '), B=(', $B->[ 0 ], ',', $B->[ 1 ],
            ') and C=(', $C->[ 0 ], ',', $C->[ 1 ], ")\n\n";

    my ($result, $explanation) = contains_origin( $A, $B, $C );

    printf "Output: $result%s\n", $VERBOSE ? ' because ' . $explanation : '';
}

#------------------------------------------------------------------------------
sub contains_origin
#------------------------------------------------------------------------------
{
    my ($A, $B, $C) = @_;

    for my $point ($A, $B, $C)
    {
        return (1, '(0,0) is a vertex of the triangle')
            if $point->[ 0 ] == 0 && $point->[ 1 ] == 0;
    }

    my $origin = [ 0, 0 ];

    return (1, '(0,0) is on the edge connecting A and B')
        if collinear( $A, $B, $origin );

    return (1, '(0,0) is on the edge connecting A and C')
        if collinear( $A, $C, $origin );
    
    return (1, '(0,0) is on the edge connecting B and C')
        if collinear( $B, $C, $origin );

    return (1, 'that triangle contains (0,0) in its interior')
        if point_in_triangle( $A, $B, $C );

    return (0, 'that triangle does not contain (0,0)');
}

#------------------------------------------------------------------------------
sub point_in_triangle
#------------------------------------------------------------------------------
{
    my ($A, $B, $C) = @_;

    my  $den =  ($B->[1] - $C->[1]) * ($A->[0] - $C->[0]) +
                ($C->[0] - $B->[0]) * ($A->[1] - $C->[1]);

    my  $x   = (($B->[1] - $C->[1]) * -$C->[0]  +
                ($C->[0] - $B->[0]) * -$C->[1]) / $den;

    my  $y   = (($C->[1] - $A->[1]) * -$C->[0]  +
                ($A->[0] - $C->[0]) * -$C->[1]) / $den;

    my  $z   = 1 - $x - $y;

    return 0 <= $x <= 1 &&
           0 <= $y <= 1 &&
           0 <= $z <= 1;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 6 or error( "Expected 6 command-line arguments, found $args" );

    for (@ARGV)
    {
        / ^ $RE{num}{real} $ /x or error( qq[Item "$_" is not a real number] );
    }

    my @A = @ARGV[ 0, 1 ];
    my @B = @ARGV[ 2, 3 ];
    my @C = @ARGV[ 4, 5 ];

    # The 3 points defining a triangle must be distinct ...

    error( 'Points A and B are identical' )
        if $A[ 0 ] == $B[ 0 ] && $A[ 1 ] == $B[ 1 ];

    error( 'Points A and C are identical' )
        if $A[ 0 ] == $C[ 0 ] && $A[ 1 ] == $C[ 1 ];

    error( 'Points B and C are identical' )
        if $B[ 0 ] == $C[ 0 ] && $B[ 1 ] == $C[ 1 ];

    # ... and not collinear

    error( 'Points A, B, and C are collinear' ) if collinear( \@A, \@B, \@C );

    return (\@A, \@B, \@C);
}

#------------------------------------------------------------------------------
sub collinear
#------------------------------------------------------------------------------
{
    my ($A, $B, $C) = @_;

    return $A->[0] * ($B->[1] - $C->[1]) +
           $B->[0] * ($C->[1] - $A->[1]) +
           $C->[0] * ($A->[1] - $B->[1]) == 0;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
