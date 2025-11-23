#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 348 Task 2: Co[n]vert Time
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub convert_time( $source, $target ) {
    my ( $source_min, $target_min ) =
        map { /(\d+):(\d+)/; ( $1 * 60 + $2 )  } $source, $target;
    my $diff = ( $target_min - $source_min ) % ( 24 * 60 );
    my $n = 0;
    for ( 60, 15, 5 ) {
        $n += int( $diff / $_ );
        $diff %= $_;
    };
    return $n + $diff;
}

use Test2::V0 qw( -no_srand );

is convert_time( "02:30", "02:45" ), 1,
    'Example 1: convert_time( "02:30", "02:45" ) == 1';
is convert_time( "11:55", "12:15" ), 2,
    'Example 2: convert_time( "11:55", "12:15" ) == 2';
is convert_time( "09:00", "13:00" ), 4,
    'Example 3: convert_time( "09:00", "13:00" ) == 4';
is convert_time( "23:45", "00:30" ), 3,
    'Example 4: convert_time( "23:45", "00:30" ) == 3';
is convert_time( "14:20", "15:25" ), 2,
    'Example 5: convert_time( "14:20", "15:25" ) == 2';

done_testing;
