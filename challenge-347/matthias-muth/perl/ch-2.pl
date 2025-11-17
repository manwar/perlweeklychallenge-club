#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 347 Task 2: Format Phone Number
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub format_phone_number( $phone ) {
    for ( $phone ) {
        s/\D//g;
        my @groups = /(..?.?)/g;
        substr( $groups[-1], 0, 0, substr( $groups[-2], -1, 1, "" ) )
            if length( $groups[-1] ) == 1;
        return join "-", @groups;
    }
}

use Test2::V0 qw( -no_srand );

is format_phone_number( "1-23-45-6" ), "123-456",
    'Example 1: format_phone_number( "1-23-45-6" ) == "123-456"';
is format_phone_number( 1234 ), "12-34",
    'Example 2: format_phone_number( 1234 ) == "12-34"';
is format_phone_number( "12 345-6789" ), "123-456-789",
    'Example 3: format_phone_number( "12 345-6789" ) == "123-456-789"';
is format_phone_number( "123 4567" ), "123-45-67",
    'Example 4: format_phone_number( "123 4567" ) == "123-45-67"';
is format_phone_number( "123 456-78" ), "123-456-78",
    'Example 5: format_phone_number( "123 456-78" ) == "123-456-78"';

done_testing;
