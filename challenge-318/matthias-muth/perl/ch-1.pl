#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 318 Task 1: Group Position
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub group_position_1( $str ) {
    my @groups = grep /^.$/, $str =~ /( (.)\g{-1}{2,} )/xg;
    return @groups ? @groups : "";
}

sub group_position_2( $str ) {
    my @groups;
    push @groups, $&
        while $str =~ /(.)\g{-1}{2,}/g;
    return @groups ? @groups : "";
}

sub group_position( $str ) {
    my @groups = grep length > 1, $str =~ /( (.)\g{-1}{2,} )/xg;
    return @groups ? @groups : "";
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ group_position( "abccccd" ) ], [ "cccc" ],
    'Example 1: group_position( "abccccd" ) == "cccc"';
is [ group_position( "aaabcddddeefff" ) ], [ "aaa", "dddd", "fff" ],
    'Example 2: group_position( "aaabcddddeefff" ) == ("aaa", "dddd", "fff")';
is [ group_position( "abcdd" ) ], [ "" ],
    'Example 3: group_position( "abcdd" ) == ""';

done_testing;
