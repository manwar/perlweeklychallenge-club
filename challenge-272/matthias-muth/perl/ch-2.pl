#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 272 Task 2: String Score
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );
use List::MoreUtils qw( slide );

sub string_score_0( $str ) {
    my @characters = split "", $str;
    my $sum = 0;
    for ( 0 .. $#characters - 1 ) {
        $sum += abs( ord( $characters[$_] ) - ord( $characters[ $_ + 1 ] ) );
    }
    return $sum;
}

sub string_score_1( $str ) {
    my @characters = split "", $str;
    my $sum = sum(
        map abs( ord( $characters[$_] ) - ord( $characters[ $_ + 1 ] ) ),
            0 .. $#characters - 1
    );
    return $sum;
}

sub string_score_2( $str ) {
    use List::Util qw( sum );
    use List::MoreUtils qw( slide );

    my @characters = split "", $str;
    my $sum = sum( slide { abs( ord( $a ) - ord( $b ) ) } @characters );
    return $sum;
}

sub string_score( $str ) {
    return sum( slide { abs( ord( $a ) - ord( $b ) ) } split "", $str );
}

sub string_score_4( $str ) {
    return sum( slide { abs( $a - $b ) } map ord( $_ ), split "", $str );
}

use Test2::V0 qw( -no_srand );
is string_score( "hello" ), 13,
    'Example 1: string_score( "hello" ) == 13';
is string_score( "perl" ), 30,
    'Example 2: string_score( "perl" ) == 30';
is string_score( "raku" ), 37,
    'Example 3: string_score( "raku" ) == 37';
done_testing;
