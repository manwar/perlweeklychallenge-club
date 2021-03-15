#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

use List::Util qw{min max sum};

# You are given three points in the plane, as a list of
# six co-ordinates: A=(x1,y1), B=(x2,y2) and C=(x3,y3).
#
# Write a script to find out if the triangle formed by
# the given three co-ordinates contain origin (0,0).
#
# Print 1 if found otherwise 0.

my @input;
push @input, [ [ [ 0,  1 ],  [ 1,  0 ],  [ 2,  2 ] ],  0 ];
push @input, [ [ [ 1,  1 ],  [ -1, 1 ],  [ 0,  -3 ] ], 1 ];
push @input, [ [ [ 0,  1 ],  [ 2,  0 ],  [ -6, 0 ] ],  1 ];
push @input, [ [ [ -5, 0 ],  [ 4,  3 ],  [ 3,  -4 ] ], 1 ];
push @input, [ [ [ 1,  2 ],  [ 4,  3 ],  [ 3,  4 ] ],  0 ];
push @input, [ [ [ -1, -2 ], [ -4, -3 ], [ -3, -4 ] ], 0 ];

for my $input (@input) {
    my ( $triangle, $test ) = $input->@*;
    my $output = contains_origin($triangle);
    say join "  ", map { join ',', $_->@* } $triangle->@*;
    say join ' : ', $test, $output;
    map_points($triangle);
}

# *A* way to determine if a point P is within the triangle
# formed by points A, B, C  is to find the area of the
# triangle, then find the sub-triangles formed by
#   P, A, B
#   P, A, C
#   P, B, C
# the area of ABC will equal the sums of the others, if
# P is within the triangle

sub contains_origin ( $triangle ) {
    my ( $A, $B, $C ) = $triangle->@*;
    my $o = [ 0, 0 ];
    my $area  = find_area( $A, $B, $C );
    my $area1 = find_area( $A, $B, $o );
    my $area2 = find_area( $A, $o, $C );
    my $area3 = find_area( $o, $B, $C );
    my $sum = sum $area1, $area2, $area3;
    return $sum == $area ? 1 : 0;
}

# I found another Perl programmer to show me how to find the area
# of a triangle
# https://github.polettix.it/ETOOBUSY/2020/10/01/area-of-triangle/

sub find_area ( $A, $B, $C ) {
    my ( $v_x, $v_y ) = map { $B->[$_] - $A->[$_] } 0 .. 1;
    my ( $w_x, $w_y ) = map { $C->[$_] - $A->[$_] } 0 .. 1;
    my $vv = $v_x * $v_x + $v_y * $v_y;
    my $ww = $w_x * $w_x + $w_y * $w_y;
    my $vw = $v_x * $w_x + $v_y * $w_y;
    return sqrt( $vv * $ww - $vw * $vw ) / 2;
}

# this is thrown in as a bonus: showing the graph with the origin
# represented as * and the points shown as +

sub map_points( $list ) {
    my %points;
    for my $p ( $list->@* ) { $points{ $p->[0] }{ $p->[1] } = 1; }
    my @x = map { $_->[0] } $list->@*;
    my @y = map { $_->[1] } $list->@*;
    my $minx = -1 + min 0, @x;
    my $miny = -1 + min 0, @y;
    my $maxx = 1 + max 0,  @x;
    my $maxy = 1 + max 0,  @y;
    say '';

    say join ' ', '+', ( map { '-' } $minx .. $maxx ), '+';

    for my $y ( reverse $miny .. $maxy ) {
        print '| ';
        for my $x ( $minx .. $maxx ) {
            if ( defined $points{$x}{$y} ) { print '+' }
            elsif ( $x == 0 && $y == 0 ) { print '*' }
            elsif ( $x == 0 ) { print '|' }
            elsif ( $y == 0 ) { print '-' }
            else              { print ' ' }
            print ' ';
        }
        say '|';
    }
    say join ' ', '+', ( map { '-' } $minx .. $maxx ), '+';
    say '';
}
