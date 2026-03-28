#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 366 Task 1: Count Prefixes
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub count_prefixes( $array, $str ) {
    return scalar grep $_ eq substr( $str, 0, length( $_ ) ), $array->@*;
}

sub count_prefixes_regex( $array, $str ) {
    my $re = join " ",
        map( "(?:$_", split( "", $str ) ),
        map( ")?",    split( "", $str ) );
    return scalar grep /^ ${re} $/x, $array->@*;
}

use Test2::V0 qw( -no_srand );
no strict 'refs';
for my $sub ( qw( count_prefixes count_prefixes_regex ) ) {
    is $sub->( ["a", "ap", "app", "apple", "banana"], "apple" ), 4,
        "Example 1: $sub( "
            . '["a", "ap", "app", "apple", "banana"], "apple" ) == 4';
    is $sub->( ["cat", "dog", "fish"], "bird" ), 0,
        "Example 2: $sub( "
            . '["cat", "dog", "fish"], "bird" ) == 0';
    is $sub->( ["hello", "he", "hell", "heaven", "he"], "hello" ), 4,
        "Example 3: $sub( "
            . '["hello", "he", "hell", "heaven", "he"], "hello" ) == 4';
    is $sub->( ["", "code", "coding", "cod"], "coding" ), 3,
        "Example 4: $sub( "
            . '["", "code", "coding", "cod"], "coding" ) == 3';
    is $sub->( ["p", "pr", "pro", "prog", "progr", "progra", "program"],
            "program" ), 7,
        "Example 5: $sub( "
            . '["p", "pr", "pro", "prog", "progr", "progra", "program"],'
            . ' "program" ) == 7';
}
done_testing;
