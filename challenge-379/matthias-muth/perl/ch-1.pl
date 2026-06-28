#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 379 Task 1: Reverse String
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub reverse_string_destructive( $str ) {
    my $reversed = "";
    $reversed .= substr( $str, -1, 1, "" )
        while length $str > 0;
    return $reversed;
}

sub reverse_string( $str ) {
    my $reversed = "";
    $reversed .= substr( $str, length( $str ) - $_, 1 )
        for 1 .. length( $str );
    return $reversed;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "", "" ],
    [ "Example 2", "reverse the given string", "gnirts nevig eht esrever" ],
    [ "Example 3", "Perl is Awesome", "emosewA si lreP" ],
    [ "Example 4", "v1.0.0-Beta!", "!ateB-0.0.1v" ],
    [ "Example 5", "racecar", "racecar" ],
);

is reverse_string( $_->[1] ), $_->[2], $_->[0]
    for @tests;
done_testing;
