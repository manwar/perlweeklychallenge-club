#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 385 Task 2: Outermost Parentheses
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub outermost_parentheses( $str ) {
    return $str =~ s/ \( ( (?R)* ) \) /$1/xgr;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "()()()", "" ],
    [ "Example 2", "(((())))", "((()))" ],
    [ "Example 3", "(()())(())", "()()()" ],
    [ "Example 4", "()((()))()", "(())" ],
    [ "Example 5", "(()(()))(()())", "()(())()()" ],
);


is outermost_parentheses( $_->[1] ), $_->[2], $_->[0]
    for @tests;

done_testing;
