#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 346 Task 1: Longest Parenthesis
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );

sub longest_parenthesis( $str ) {
    return max( map length, $str =~ / (?: \( (?R)* \) )+ /xg );
}

use Test2::V0 qw( -no_srand );

is longest_parenthesis( "(()())" ), 6,
    'Example 1: longest_parenthesis( "(()())" ) == 6';
is longest_parenthesis( ")()())" ), 4,
    'Example 2: longest_parenthesis( ")()())" ) == 4';
is longest_parenthesis( "((()))()(((()" ), 8,
    'Example 3: longest_parenthesis( "((()))()(((()" ) == 8';
is longest_parenthesis( "))))((()(" ), 2,
    'Example 4: longest_parenthesis( "))))((()(" ) == 2';
is longest_parenthesis( "()(()" ), 2,
    'Example 5: longest_parenthesis( "()(()" ) == 2';

done_testing;
