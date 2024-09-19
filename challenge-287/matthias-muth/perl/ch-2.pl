#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 287 Task 2: Valid Number
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub valid_number( $str ) {
    return $str =~ /^ [+-]? (?: \.\d+ | \d+(?:\.\d*)? ) (?: [Ee] [+-]? \d+ )? $/xa;
}

use Regexp::Common;

sub Xvalid_number( $str ) {
    return $str =~ /^$RE{num}{real}$/;
}

use Test2::V0 qw( -no_srand );
ok valid_number( 1 ),
    'Example 1: valid_number( 1 ) is true';
ok ! valid_number( "a" ),
    'Example 2: valid_number( "a" ) is false';
ok ! valid_number( "." ),
    'Example 3: valid_number( "." ) is false';
ok ! valid_number( "1.2e4.2" ),
    'Example 4: valid_number( "1.2e4.2" ) is false';
ok valid_number( "-1." ),
    'Example 5: valid_number( "-1." ) is true';
ok valid_number( "+1E-8" ),
    'Example 6: valid_number( "+1E-8" ) is true';
ok valid_number( ".44" ),
    'Example 7: valid_number( ".44" ) is true';
done_testing;
