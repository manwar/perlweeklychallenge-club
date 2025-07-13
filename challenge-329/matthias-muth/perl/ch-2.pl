#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 329 Task 2: Nice String
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( uniq );

sub is_nice_string( $str ) {
    my $lower = join "", sort +( uniq $str =~ /([a-z])/g );
    my $upper = join "", sort +( uniq $str =~ /([A-Z])/g );
    return $upper eq uc( $lower );
}

sub longest_nice_substring( $str ) {
    my ( $start, $longest_nice, $min_length ) = ( 0, "", 2 );
    while ( $start + $min_length <= length( $str ) ) {
        for my $len ( $min_length .. length( $str ) - $start ) {
            my $substr = substr( $str, $start, $len );
            if ( is_nice_string( $substr ) ) {
                $longest_nice = $substr;
                $min_length = length( $longest_nice ) + 1;
            }
        }
        ++$start;
    }
    return $longest_nice;
}

use Test2::V0 qw( -no_srand );

is longest_nice_substring( "YaaAho" ), "aaA",
    'Example 1: longest_nice_substring( "YaaAho" ) == "aaA"';
is longest_nice_substring( "cC" ), "cC",
    'Example 2: longest_nice_substring( "cC" ) == "cC"';
is longest_nice_substring( "A" ), "",
    'Example 3: longest_nice_substring( "A" ) == ""';
is longest_nice_substring( "XabcABCX" ), "abcABC",
    'Test 1: longest_nice_substring( "XabcABCX" ) == "abcABC"';
is longest_nice_substring( "XaAbBcCX" ), "aAbBcC",
    'Test 2: longest_nice_substring( "XaAbBcCX" ) == "aAbBcC"';
is longest_nice_substring( "notniceANOTNICEXniceNICEXaA" ), "niceNICE",
    'Test 3: longest_nice_substring( "notniceANOTNICEXniceNICEXaA" )'
        . ' == "niceNICE"';

done_testing;
