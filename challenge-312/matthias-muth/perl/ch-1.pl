#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 312 Task 1: Minimum Time
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( min );

sub wheel_distance( $a, $b ) {
    my $d = abs( ord( $a ) - ord( $b ) );
    return min( $d, 26 - $d );
}

sub minimum_time( $str ) {
    my ( $sum, $current_letter ) = ( 0, 'a' );
    for my $next_letter ( split "", $str ) {
        $sum += wheel_distance( $current_letter, $next_letter ) + 1;
        $current_letter = $next_letter;
    }
    return $sum;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

if ( my $print_matrix = 0 ) {
    say " ", map "  $_", "a".."z";
    for my $a ( 'a'..'z' ) {
        say $a, map sprintf( "%3d", wheel_distance( $a, $_ ) ), 'a'..'z';
    }
}

is minimum_time( "abc" ), 5,
    'Example 1: minimum_time( "abc" ) == 5';
is minimum_time( "bza" ), 7,
    'Example 2: minimum_time( "bza" ) == 7';
is minimum_time( "zjpc" ), 34,
    'Example 3: minimum_time( "zjpc" ) == 34';

done_testing;
