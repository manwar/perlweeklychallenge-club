#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 328 Task 1: Replace all ?
#
#       Perl solution by Matthias Muth.
#

use v5.30;
use feature 'signatures';
no warnings 'experimental::signatures';

sub replace_all_questionmarks( $str ) {
    # Looking for a '?', capturing a one-character look-behind in $1
    # and a one-character look-ahead in $2 (both possibly empty,
    # but always defined).
    # Pity that the capture of (^|.) within the look-behind results in an
    # 'experimental' warning because of its variable length.
    # Resolved this by switching off the warning.
    no warnings 'experimental';
    $str =~
        s[ (?<=(^|.)) \? (?=(.|$)) ] {
            my ( $left, $right ) = ( $1, $2 );
            $left eq "a"    ? ( $right eq "b" ? "c" : "b" )
            : $right eq "a" ? ( $left eq "b"  ? "c" : "b" ) : "a";
        }xegr;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Test 0:", "", "" ],
    [ "Test 1:", "?", "a" ],
    [ "Test 2:", "a?", "ab" ],
    [ "Test 3:", "b?", "ba" ],
    [ "Test 4:", "c?", "ca" ],
    [ "Test 5:", "?a", "ba" ],
    [ "Test 6:", "?b", "ab" ],
    [ "Test 7:", "?c", "ac" ],
    [ "Test 8:", "a?a a?b a?x", "aba acb abx" ],
    [ "Test 9:", "b?a b?b b?x", "bca bab bax" ],
    [ "Test 10:", "x?a x?b x?x", "xba xab xax" ],
    [ "Example 1:", "a?z", "abz" ],
    [ "Example 2:", "pe?k", "peak" ],
    [ "Example 3:", "gra?te", "grabte" ],
);

for ( @tests ) {
    my ( $descr, $input, $expected ) = $_->@*;
    $descr .= " replace_all_questionmarks( '$input' ) is '$expected'";
    is replace_all_questionmarks( $input ), $expected, $descr;
}

done_testing;
