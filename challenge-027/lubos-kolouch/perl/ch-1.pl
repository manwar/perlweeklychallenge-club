#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 1: Intersection of two straight lines
# Two lines defined by endpoints (a,b)-(c,d) and (p,q)-(r,s).
# Find their intersection point assuming lines are infinitely long.

sub get_intersection ( $a, $b, $c, $d, $p, $q, $r, $s ) {
    my $det = ( $a - $c ) * ( $q - $s ) - ( $b - $d ) * ( $p - $r );
    return if $det == 0;

    my $term1 = $a * $d - $b * $c;
    my $term2 = $p * $s - $q * $r;

    my $px = ( $term1 * ( $p - $r ) - ( $a - $c ) * $term2 ) / $det;
    my $py = ( $term1 * ( $q - $s ) - ( $b - $d ) * $term2 ) / $det;

    return [ $px, $py ];
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is_deeply( get_intersection( 0, 0, 2, 0, -4, -5, 8, 1 ), [ 6, 0 ], 'Intersection at (6, 0)' );
    is_deeply( get_intersection( 0, 0, 2, 0, -4, -5, 8, 0 ), [ 8, 0 ], 'Intersection at (8, 0)' );
    is_deeply( get_intersection( 0, 0, 2, 1, -4, -5, 2, 1 ), [ 2, 1 ], 'Intersection at (2, 1)' );
    is( get_intersection( 1, 2, 3, 4, 5, 6, 7, 8 ), undef, 'Parallel lines return undef' );

    done_testing();
}
else {
    die 'Usage: ch-1.pl a b c d p q r s' unless @ARGV == 8;
    my $res = get_intersection(@ARGV);
    if ($res) {
        say "Intersection : $res->[0] , $res->[1]";
    }
    else {
        say "Lines are parallel (no intersection)";
    }
}
