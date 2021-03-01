#! /opt/local/bin/perl
#
#       three-walls-around-me.pl
#
#         TASK #2 › Origin-containing Triangle
#         Submitted by: Stuart Little
#         You are given three points in the plane, as a list of six
#         co-ordinates: A=(x1,y1), B=(x2,y2) and C=(x3,y3).
# 
#         Write a script to find out if the triangle formed by the given three
#         co-ordinates contain origin (0,0).
# 
#         Print 1 if found otherwise 0.
# 
#         Example 1:
# 
#             Input : A=(0,1), B=(1,0) and C=(2,2)
#             Output: 0 because that triangle does not contain (0,0).
# 
#         Example 2:
# 
#             Input : A=(1,1), B=(-1,1) and C=(0,-3)
#             Output: 1 because that triangle contains (0,0) in its interior.
# 
#         Example 3:
# 
#             Input : A=(0,1), B=(2,0) and C=(-6,0)
#             Output: 1 because (0,0) is on the edge connecting B and C.
# 
#       method:
# 
#             avoids having to orient the triangle by short-circuiting 
#             should any dot product equal 0. Inside if all procucts are 
#             positive, all negative, or any value is 0.
# 
#             1. barycentric 
#             2. parametric
#             3. product
#             4. equal sum of triangle area
#             5. single edge intersection with line from infinity
#             
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";


package main;
use feature qw(signatures);
no warnings 'experimental::signatures';


@ARGV = (0,-4, 0,4, - 4,0);

say origin_inside_triangle( @ARGV ) if @ARGV;

sub origin_inside_triangle ( @triangle ) {
    return place_origin( @triangle );
}

sub dot_product ( $x1,$y1, $x2,$y2 ) {
    my $v = (($y2-$y1)*(-$x1) + (-$x2+$x1)*(-$y1));
    return $v > 0 ? 1 : $v < 0 ? -1 : 0;
}

sub place_origin ( $x1, $y1, $x2, $y2, $x3, $y3 ) {
# return true if all positive, all negative or any 0
    my $s1 = dot_product( $x1,$y1, $x2,$y2 );
    my $s2 = dot_product( $x2,$y2, $x3,$y3 );
    my $s3 = dot_product( $x3,$y3, $x1,$y1 );
    
    return 1 if $s1*$s2*$s3 == 0;
    
    my $sum = $s1 + $s2 + $s3;
    return ($sum == -3 || $sum == 3) ? 1 : 0;
}

## TESTING
use Test::More;

is origin_inside_triangle(0,1, 1,0, 2,2)  ,   0, 'ex-1';
is origin_inside_triangle(1,1, -1,1, 0,-3),   1, 'ex-2';
is origin_inside_triangle(0,1, 2,0, -6,0) ,   1, 'ex-3';


is origin_inside_triangle(-4,-4, -2,4, 3,-4), 1, '3 quadrants';
is origin_inside_triangle(-4,-4, -2,4, 3,-4), 1, 'origin is vertex';

is origin_inside_triangle(-4,0, 4,0, 4,4 ),   1, 'origin on line - ccw orientation';
is origin_inside_triangle(-4,0, 4,0, -4,-4 ), 1, 'origin on line - cw orientation';
is origin_inside_triangle(-4,-4, -2,4, 3,-4), 1, 'origin is vertex';
is origin_inside_triangle(-4,1, 4,1, 4,4),    0,  'outside';

done_testing();
