#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 360 Task 2: Word Sorter
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub word_sorter( $str ) {
    return join " ", sort { fc $a cmp fc $b } split " ", $str;
}

my @tests = (
    [ 'Example 1:', [ "The quick brown fox" ], [ "brown fox quick The" ] ],
    [ 'Example 2:', [ "Hello    World!   How   are you?" ],
                    [ "are Hello How World! you?" ] ],
    [ 'Example 3:', [ "Hello" ], [ "Hello" ] ],
    [ 'Example 4:', [ "Hello, World! How are you?" ],
                    [ "are Hello, How World! you?" ] ],
    [ 'Example 5:', [ "I have 2 apples and 3 bananas!" ],
                    [ "2 3 and apples bananas! have I" ] ],
);

use MultiTest;
run_tests( "word_sorter", @tests );
