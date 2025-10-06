#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

=head1 NAME

ch-1.pl - Perl Weekly Challenge - Task 1: Balance String

=head1 DESCRIPTION

You are given a string made up of lowercase English letters and digits only.

Write a script to format the give string where no letter is followed by another letter and no digit is followed by another digit. If there are multiple valid rearrangements, always return the lexicographically smallest one. Return empty string if it is impossible to format the string.

=head1 USAGE

perl ch-1.pl

=head1 AUTHOR

Lubos Kolouch

=cut

=head1 FUNCTIONS

=head2 balance_string

    my $formatted = balance_string($str);

Returns the lexicographically smallest formatted string where no two letters or two digits are adjacent, or empty string if impossible.

=cut

sub balance_string {
    my ($str) = @_;

    # Separate letters and digits
    my @letters = sort grep /[a-z]/, split //, $str;
    my @digits  = sort grep /\d/,    split //, $str;

    # Check if valid rearrangement is possible
    my $diff = @letters - @digits;
    return "" if $diff > 1 || $diff < -1;

    my @result;
    my ( $i, $j ) = ( 0, 0 );

    # Start with the more frequent type
    if ( @letters > @digits ) {

        # Start with letter
        while ( $i < @letters || $j < @digits ) {
            push @result, $letters[$i] if $i < @letters;
            $i++;
            push @result, $digits[$j] if $j < @digits;
            $j++;
        }
    }
    else {
        # Start with digit (or equal counts, digit first for lexicographical order)
        while ( $i < @letters || $j < @digits ) {
            push @result, $digits[$j] if $j < @digits;
            $j++;
            push @result, $letters[$i] if $i < @letters;
            $i++;
        }
    }

    return join "", @result;
}

=head1 TESTS

=head2 Test Example 1

Input: $str = "a0b1c2"

Output: "0a1b2c"

=cut

is( balance_string("a0b1c2"), "0a1b2c", "Example 1: a0b1c2 -> 0a1b2c" );

=head2 Test Example 2

Input: $str = "abc12"

Output: "a1b2c"

=cut

is( balance_string("abc12"), "a1b2c", "Example 2: abc12 -> a1b2c" );

=head2 Test Example 3

Input: $str = "0a2b1c3"

Output: "0a1b2c3"

=cut

is( balance_string("0a2b1c3"), "0a1b2c3", "Example 3: 0a2b1c3 -> 0a1b2c3" );

=head2 Test Example 4

Input: $str = "1a23"

Output: ""

=cut

is( balance_string("1a23"), "", "Example 4: 1a23 -> ''" );

=head2 Test Example 5

Input: $str = "ab123"

Output: "1a2b3"

=cut

is( balance_string("ab123"), "1a2b3", "Example 5: ab123 -> 1a2b3" );

done_testing;
