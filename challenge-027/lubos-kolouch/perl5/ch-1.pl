#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: Perl Weekly Challenge - 027
#  https://perlweeklychallenge.org/blog/perl-weekly-challenge-027/
#
#
#    Write a script to find the intersection of two straight lines. The co-ordinates of the two lines should be provided as command line parameter. For example:
#
#       The two ends of Line 1 are represented as co-ordinates (a,b) and (c,d).
#
#        The two ends of Line 2 are represented as co-ordinates (p,q) and (r,s).
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 09/28/2019 01:50:52 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

die 'Usage: ch-1.pl a b c d p q r s' unless @ARGV == 8;

sub get_intersection {

    my ( $a, $b, $c, $d, $p, $q, $r, $s ) = @_;
    #     x1  y1  x2  y2  x3  y3  x4  y4

    my $det = ( $a - $c ) * ( $q - $s ) - ( $b - $d ) * ( $p - $r );
    return 0 if $det == 0;

    # Let's assume the lines are infinitely long
    my $px = ( $a * $d - $b * $c ) * ( $p - $r ) - ( $a - $c ) * ( $p * $s - $q * $r ) / $det;

    my $py = ( $a * $d - $b * $c ) * ( $q - $s ) - ( $b - $d ) * ( $p * $s - $q * $r ) / $det;

    return ( [ $px, $py ] );
}

my ($result) = &get_intersection(@ARGV);
say "Intersection : $result->[0] , $result->[1]";

# TESTS
use Test::More;

is_deeply( \&get_intersection( 0, 0, 2, 0, -4, -5, 8, 1 ), \[ 6, 0 ] );
is_deeply( \&get_intersection( 0, 0, 2, 0, -4, -5, 8, 0 ), \[ 8, 0 ] );
is_deeply( \&get_intersection( 0, 0, 2, 1, -4, -5, 2, 1 ), \[ 2, 1 ] );

is( &get_intersection( 1, 2, 3, 4, 5, 6, 7, 8 ), 0 );

done_testing;

