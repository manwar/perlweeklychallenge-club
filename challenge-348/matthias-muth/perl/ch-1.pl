#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 348 Task 1: String Alike
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub string_alike( $str ) {
    my $half_length = length( $str ) / 2;
    my ( $n_1, $n_2 ) = map tr/aeiouAEIOU//,
        substr( $str, 0, $half_length ),
        substr( $str, $half_length );
    return $n_1 > 0 && $n_2 == $n_1;
}

use Test2::V0 qw( -no_srand );

is string_alike( "textbook" ), F,
    'Example 1: string_alike( "textbook" ) is false';
is string_alike( "book" ), T,
    'Example 2: string_alike( "book" ) is true';
is string_alike( "AbCdEfGh" ), T,
    'Example 3: string_alike( "AbCdEfGh" ) is true';
is string_alike( "rhythmmyth" ), F,
    'Example 4: string_alike( "rhythmmyth" ) is false';
is string_alike( "UmpireeAudio" ), F,
    'Example 5: string_alike( "UmpireeAudio" ) is false';

done_testing;
