#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 364 Task 1: Decrypt String
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub decrypt_string( $str ) {
    return $str =~ s< ( 1\d | 2[0-6] ) \# | ( \d )>{
        chr( ord( 'a' ) + ( $1 // $2 ) - 1 )
    }xegr;
}

use Test2::V0 qw( -no_srand );

is decrypt_string( "10#11#12" ), "jkab",
    'Example 1: decrypt_string( "10#11#12" ) eq "jkab"';
is decrypt_string( "1326#" ), "acz",
    'Example 2: decrypt_string( "1326#" ) eq "acz"';
is decrypt_string( "25#24#123" ), "yxabc",
    'Example 3: decrypt_string( "25#24#123" ) eq "yxabc"';
is decrypt_string( "20#5" ), "te",
    'Example 4: decrypt_string( "20#5" ) eq "te"';
is decrypt_string( "1910#26#" ), "aijz",
    'Example 5: decrypt_string( "1910#26#" ) eq "aijz"';

is decrypt_string( "27#" ), "bg#",
    'Niels van Dijke test: decrypt_string( "27#" ) eq "bg#"';
is decrypt_string( "715#15#15#112#" ), "goooal",
    'Goooal!';

done_testing;
