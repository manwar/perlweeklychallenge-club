#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 280 Task 1: Twice Appearance
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub twice_appearance_WRONG( $str ) {
    return $str =~ /(.).*?\g1/ ? $1 : "";
}

sub twice_appearance( $str ) {
    my %seen;
    for ( split "", $str ) {
        return $_
            if $seen{$_};
        $seen{$_} = 1;
    }
    return ();
}

sub twice_appearance_WRONG( $str ) {
    return $str =~ /(.)(?<!^.*\g1.*)/ ? $1 : "";
}

use Test2::V0 qw( -no_srand );
is twice_appearance( "acbddbca" ), "d",
    'Example 1: twice_appearance( "acbddbca" ) == "d"';
is twice_appearance( "abccd" ), "c",
    'Example 2: twice_appearance( "abccd" ) == "c"';
is twice_appearance( "abcdabbb" ), "a",
    'Example 3: twice_appearance( "abcdabbb" ) == "a"';
done_testing;
