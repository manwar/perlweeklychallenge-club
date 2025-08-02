#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 275 Task 2: Replace Digits
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub replace_digits( $str ) {
    return $str =~ s{([[:alpha:]])(\d)}{ $1 . chr( ord( $1 ) + $2 ) }egr;
}

sub replace_digits_2( $str ) {
    while ( $str =~
        s{([[:alpha:]])(\d*)(\d)}{ "$1$2" . chr( ord( $1 ) + $3 ) }e )
    {
        # Everything is in the loop condiiton.
    }
    return $str;
}

sub replace_digits_3( $str ) {
    return $str =~ s{ ([[:alpha:]]) (\d+) }{
            join "", $1, map chr( ord( $1 ) + $_ ), split "", $2;
        }xegr;
}

use Test2::V0 qw( -no_srand );
is replace_digits( "a1c1e1" ), "abcdef",
    'Example 1: replace_digits( "a1c1e1" ) == "abcdef"';
is replace_digits( "a1b2c3d4" ), "abbdcfdh",
    'Example 2: replace_digits( "a1b2c3d4" ) == "abbdcfdh"';
is replace_digits( "b2b" ), "bdb",
    'Example 3: replace_digits( "b2b" ) == "bdb"';
is replace_digits( "a16z" ), "abgz",
    'Example 4: replace_digits( "a16z" ) == "abgz"';
done_testing;
