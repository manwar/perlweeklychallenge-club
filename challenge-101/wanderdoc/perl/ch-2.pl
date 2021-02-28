#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given three points in the plane, as a list of six co-ordinates: A=(x1,y1), B=(x2,y2) and C=(x3,y3). Write a script to find out if the triangle formed by the given three co-ordinates contain origin (0,0).
Print 1 if found otherwise 0.
Example 1: Input: A=(0,1), B=(1,0) and C=(2,2) Output: 0 because that triangle does not contain (0,0).
Example 2: Input: A=(1,1), B=(-1,1) and C=(0,-3) Output: 1 because that triangle contains (0,0) in its interior.
Example 3: Input: A=(0,1), B=(2,0) and C=(-6,0) Output: 1 because (0,0) is on the edge connecting B and C.
=cut







use Struct::Dumb;

struct Point => [qw( x y )];

sub point_in_triangle
{
     my ($pA, $pB, $pC, $pP) = @_;

     my $denominator_barycentric =
          (($pB->y - $pC->y)*($pA->x - $pC->x) + 
           ($pC->x - $pB->x)*($pA->y - $pC->y));

     my $coord_a = (($pB->y - $pC->y)*($pP->x - $pC->x) + 
                    ($pC->x - $pB->x)*($pP->y - $pC->y)) / 
                    $denominator_barycentric;

     my $coord_b = (($pC->y - $pA->y)*($pP->x - $pC->x) + 
                    ($pA->x - $pC->x)*($pP->y - $pC->y)) / 
                    $denominator_barycentric;
     my $coord_c = 1 - $coord_a -  $coord_b;


     if ( $coord_a >= 0 and $coord_a <= 1 and 
          $coord_b >= 0 and $coord_b <= 1 and 
          $coord_c >= 0 and $coord_c <= 1)

     {
          return 1;
     }
     return 0;

}

my $ORIGIN = Point(0, 0);


for my $triangle (  [[0, 1], [ 1, 0], [ 2,  2]],
                    [[1, 1], [-1, 1], [ 0, -3]],
                    [[0, 1], [ 2, 0], [-6,  0]] )

{
     my @points = map { Point($_->[0], $_->[1]) } @$triangle;
     print point_in_triangle( @points, $ORIGIN ), $/;
}