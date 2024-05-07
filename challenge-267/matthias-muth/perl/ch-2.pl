#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 267 Task 2: Line Counts
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub line_counts( $str, $widths ) {
    my ( $n_lines, $current_line_width ) = ( $str ne "" || 0, 0 );
    for ( split "", $str ) {
        my $char_width = $widths->[ ord( $_ ) - ord( 'a' ) ];
        if ( $current_line_width + $char_width > 100 ) {
            ++$n_lines;
            $current_line_width = 0;
        }
        $current_line_width += $char_width;
    }
    return ( $n_lines, $current_line_width );
}

use Test2::V0 qw( -no_srand );
is [ line_counts( "", [
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10,
] ) ], [ 0, 0 ],
    'Test 1: line_counts( "", [
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10,
] ) == (0, 0)';
is [ line_counts( "abcdefghijklmnopqrstuvwxyz", [
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10,
] ) ], [ 3, 60 ],
    'Example 1: line_counts( "abcdefghijklmnopqrstuvwxyz", [
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10,
] ) == (3, 60)';
is [ line_counts( "bbbcccdddaaa", [
  4, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10,
] ) ], [ 2, 4 ],
    'Example 2: line_counts( "bbbcccdddaaa", [
  4, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
  10, 10, 10, 10, 10, 10,
] ) == (2, 4)';
done_testing;
