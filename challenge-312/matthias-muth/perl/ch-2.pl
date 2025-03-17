#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 312 Task 2: Balls and Boxes
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub balls_and_boxes_1( $str ) {
    my @boxes;
    while ( $str =~ /([RGB])(\d)/g ) {
        ++$boxes[$2]{$1};
    }
    return scalar grep $_->{'R'} && $_->{'G'} && $_->{'B'}, @boxes;
}

sub balls_and_boxes( $str ) {
    return scalar grep $str =~ /R$_/ && $str =~ /G$_/ && $str =~ /B$_/, 0..9;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is balls_and_boxes( "G0B1R2R0B0" ), 1,
    'Example 1: balls_and_boxes( "G0B1R2R0B0" ) == 1';
is balls_and_boxes( "G1R3R6B3G6B1B6R1G3" ), 3,
    'Example 2: balls_and_boxes( "G1R3R6B3G6B1B6R1G3" ) == 3';
is balls_and_boxes( "B3B2G1B3" ), 0,
    'Example 3: balls_and_boxes( "B3B2G1B3" ) == 0';

done_testing;
