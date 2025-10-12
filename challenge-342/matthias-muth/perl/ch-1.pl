#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 342 Task 1: Balance String
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( mesh );

# Equal number of letters and digits:
#     start with the digits,
#     because any digit sorts alphabetically lower than any letter.
# One letter less than digits:
#     start with the digits,
#     append an empty string to letters to have an equal number of entries
#     for `mesh`.
# One digit less than letters
#     the digits have to be 'inside' the letters,
#     we can add an empty string before the digits,
#     then we can still start with digits.

sub balance_string_1( $str ) {
    my @letters = sort $str =~ /[a-z]/g;
    my @digits = sort $str =~ /\d/g;
    return ""
        unless abs( @digits - @letters ) <= 1;
    return join "", mesh(
        @digits < @letters ? [ "", @digits ]  : \@digits,
        @digits > @letters ? [ @letters, "" ] : \@letters );
}

sub balance_string( $str ) {
    my @letters = sort $str =~ /[a-z]/g;
    my @digits  = sort $str =~ /\d/g;
    return join "",
        @letters == @digits
            ? mesh \@digits, \@letters
        : @digits == @letters + 1
            ? ( shift @digits, mesh \@letters, \@digits )
        : @letters == @digits + 1
            ? ( shift @letters, mesh \@digits, \@letters )
        : ();
}

use Test2::V0 qw( -no_srand );

is balance_string( "a0b1c2" ), "0a1b2c",
    'Example 1: balance_string( "a0b1c2" ) == "0a1b2c"';
is balance_string( "abc12" ), "a1b2c",
    'Example 2: balance_string( "abc12" ) == "a1b2c"';
is balance_string( "0a2b1c3" ), "0a1b2c3",
    'Example 3: balance_string( "0a2b1c3" ) == "0a1b2c3"';
is balance_string( "1a23" ), "",
    'Example 4: balance_string( "1a23" ) == ""';
is balance_string( "ab123" ), "1a2b3",
    'Example 5: balance_string( "ab123" ) == "1a2b3"';

done_testing;
