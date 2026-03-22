#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 365 Task 2: Valid Token Counter
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub valid_token_counter( $str ) {
    return scalar grep /^ [a-z]+ (?: - [a-z]+ )? [!,.]? $/x,
        split " ", $str;
}

use Test2::V0 qw( -no_srand );

is valid_token_counter( "cat and dog" ), 3,
    'Example 1: valid_token_counter( "cat and dog" ) == 3';
is valid_token_counter( "a-b c! d,e" ), 2,
    'Example 2: valid_token_counter( "a-b c! d,e" ) == 2';
is valid_token_counter( "hello-world! this is fun" ), 4,
    'Example 3: valid_token_counter( "hello-world! this is fun" ) == 4';
is valid_token_counter( "ab- cd-ef gh- ij!" ), 2,
    'Example 4: valid_token_counter( "ab- cd-ef gh- ij!" ) == 2';
is valid_token_counter( "wow! a-b-c nice." ), 2,
    'Example 5: valid_token_counter( "wow! a-b-c nice." ) == 2';

done_testing;
