#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 296 Task 1: String Compression
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub string_compression( $chars ) {
    return $chars =~ s/(.)\g1+/ length( $& ) . $1 /egr;
}

sub string_uncompress( $chars ) {
    return $chars =~ s/(\d+)(\D)/ $2 x $1 /egr;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is string_compression( "abbc" ), "a2bc",
    'Example 1: string_compression( "abbc" ) == "a2bc"';
is string_compression( "aaabccc" ), "3ab3c",
    'Example 2: string_compression( "aaabccc" ) == "3ab3c"';
is string_compression( "abcc" ), "ab2c",
    'Example 3: string_compression( "abcc" ) == "ab2c"';
is string_uncompress( "a2bc" ), "abbc",
    'Bonus 1: string_uncompress( "a2bc" ) == "abbc"';
is string_uncompress( "3ab3c" ), "aaabccc",
    'Bonus 2: string_uncompress( "3ab3c" ) == "aaabccc"';
is string_uncompress( "ab2c" ), "abcc",
    'Bonus 3: string_uncompress( "ab2c" ) == "abcc"';

done_testing;
