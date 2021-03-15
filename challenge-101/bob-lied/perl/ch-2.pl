#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 101, Task #2, Origin-containing Triangle
# You are given three points in the plane, as a list of six co-ordinates:
# A=(x1,y1), B=(x2,y2) and C=(x3,y3).
# Write a script to find out if the triangle formed by the given three
# coordinates contain origin (0,0).  Print 1 if found otherwise 0.
# Example 1: Input: A=(0,1), B=(1,0) and C=(2,2)
# Output: 0 because that triangle does not contain (0,0).
#
# Example 2: Input: A=(1,1), B=(-1,1) and C=(0,-3)
# Output: 1 because that triangle contains (0,0) in its interior.
#
# Example 3: Input: A=(0,1), B=(2,0) and C=(-6,0)
# Output: 1 because (0,0) is on the edge connecting B and C.
#=============================================================================

use strict;
use warnings;
use 5.020;

use experimental qw/signatures/;
no warnings qw/experimental::signatures/;

######### { Class Point
package Point;

use Moo;
    has x => ( is => 'ro', required => 1 );
    has y => ( is => 'ro', required => 1 );

no warnings qw/experimental::signatures/;   # Why do I need this?
    sub pp($self) { "($self->x,$self->y)" }
######### } Class Point

########## { Class Triangle
package Triangle;

use Moo;
    has ptA => ( is => 'ro', required => 1 );
    has ptB => ( is => 'ro', required => 1 );
    has ptC => ( is => 'ro', required => 1 );

no warnings qw/experimental::signatures/;
    sub pp($self) { join(" ; ", $self->ptA->pp(), $self->ptB->pp(), $self->ptC->pp() ); }

no warnings qw/experimental::signatures/;
    sub area($self)
    {
        my ($pa, $pb, $pc) = ($self->ptA, $self->ptB, $self->ptC);

        # No, I don't remember this from high school.  Found it on Wikipedia.
        my $area = abs( ($pa->x - $pc->x) * ($pb->y - $pa->y) - ($pa->x - $pb->x) * ( $pc->y - $pa->y) ) / 2.0;
    }
########## } Class Triangle

########## MAIN ###########
package main;

use Getopt::Long;
my $verbose = 0;
my $doTest = 0;
GetOptions("test" => \$doTest, "verbose" => \$verbose);

exit(!runTest()) if $doTest;

sub Usage { "$0 A=(1,1), B=(-1,1) and C=(0,-3)" }

# Simplified parse. Everything that doesn't look like a number becomes
# whitespace, then pairs of numbers are coordinates.
# Knowing this, could call the program with pairs of numbers as arguments
my $ptStr = join(" ", @ARGV);
$ptStr =~ s/[^0-9.+-]/ /g;
my @rawCoord = split(" ", $ptStr);

die "Need three points, like: ", Usage() unless scalar(@rawCoord) == 6;

my ($Ax, $Ay, $Bx, $By, $Cx, $Cy) = @rawCoord;

# Factory method for shorter, more readable lines of code
sub mkPt($x, $y) { return Point->new( x => $x, y => $y ) }


say triangleContains( mkPt($Ax, $Ay), mkPt($Bx, $By), mkPt($Cx, $Cy), mkPt(0, 0) );


# We can draw lines from every vertex to the point that is being tested to form
# three triangles. When the point is inside the triangle, the sum of the areas
# of those three small triangles will be equal to the area of the entire
# triangle.  If the point were outside of the triangle, the sum of the areas
# of the new triangles would be larger than the area of the original
# triangle. This factoid courtesy of Google, although I'm sure I once knew it
# at some point in my life.

# Is the point Q inside the triangle formed by A, B, and C?
sub triangleContains($vA, $vB, $vC, $vQ)
{
    my $triangle = Triangle->new( ptA => $vA, ptB => $vB, ptC => $vC);
    my $area = $triangle->area();
    say "Area: ", $area if $verbose;
    if ( $area == 0 )
    {
        # Degenerate case.  We don't actually have a triangle; we either have a
        # line segment or a point.  Is the query point on the line segment?
        use List::Util qw(max min);
        if (   $vQ->x >= min($vA->x, $vB->x, $vC->x) && $vQ->x <= max($vA->x, $vB->x, $vC->x)
            && $vQ->y >= min($vA->y, $vB->y, $vC->y) && $vQ->y <= max($vA->y, $vB->y, $vC->y) )
        {
            # Find slope and intercept from points A and B.
            my $rise = $vA->y - $vB->y;
            my $run  = $vA->x - $vB->x;
            if ( $run == 0 )
            {
                # Vertical line, is Q on it?
                return $vQ->x == $vA->x;
            }
            my $m = $rise/$run;
            my $b = $vA->y - $m * $vA->x;

            # Is Q a solution of the equation?
            return 1 if ( $vQ->y == $m * $vQ->x + $b );
        }
        return 0;
    }

    # Form triangles from every pair of vertices, using the query point
    my $area1 = Triangle->new( ptA => $vA, ptB => $vB, ptC => $vQ)->area();
    my $area2 = Triangle->new( ptA => $vA, ptB => $vQ, ptC => $vC)->area();
    my $area3 = Triangle->new( ptA => $vQ, ptB => $vB, ptC => $vC)->area();

    my $triArea = $area1 + $area2 + $area3;

    say "Sub-areas: $area1 + $area2 + $area3 = $triArea" if $verbose;

    return ( $area == $triArea ? 1 : 0 );
}

sub runTest
{
    use Test::More;
    is( triangleContains( mkPt( 0, 1), mkPt( 1, 0), mkPt( 2,  2), mkPt(0,0) ), 0, "Outside");
    is( triangleContains( mkPt( 1, 1), mkPt(-1, 1), mkPt( 0, -3), mkPt(0,0) ), 1, "Inside");
    is( triangleContains( mkPt( 0, 1), mkPt( 2, 0), mkPt(-6,  0), mkPt(0,0) ), 1, "Edge");
    is( triangleContains( mkPt( 0, 0), mkPt( 2, 2), mkPt( 6,  0), mkPt(0,0) ), 1, "Vertex");
    is( triangleContains( mkPt( 0, 0), mkPt( 0, 0), mkPt( 0,  0), mkPt(0,0) ), 1, "Degenerate point 0");
    is( triangleContains( mkPt( 1, 1), mkPt( 1, 1), mkPt( 1,  1), mkPt(0,0) ), 0, "Degenerate point 1");
    is( triangleContains( mkPt(-1, 0), mkPt( 1, 0), mkPt( 2,  0), mkPt(0,0) ), 1, "Degenerate line X 1");
    is( triangleContains( mkPt( 1, 0), mkPt( 1, 0), mkPt( 2,  0), mkPt(0,0) ), 0, "Degenerate line X 0");
    is( triangleContains( mkPt( 0, 3), mkPt( 0, 5), mkPt( 0, -2), mkPt(0,0) ), 1, "Degenerate line Y 1");
    is( triangleContains( mkPt( 0, 3), mkPt( 0, 5), mkPt( 0,  2), mkPt(0,0) ), 0, "Degenerate line Y 0");
    is( triangleContains( mkPt(11, 3), mkPt( 2, 3), mkPt( 3,  3), mkPt(0,0) ), 0, "Degenerate line 0");

    done_testing;
}
