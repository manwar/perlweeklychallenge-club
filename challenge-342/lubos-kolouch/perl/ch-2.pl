#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

=head1 NAME

ch-2.pl - Perl Weekly Challenge - Task 2: Max Score

=head1 DESCRIPTION

You are given a string, $str, containing 0 and 1 only.

Write a script to return the max score after splitting the string into two non-empty substrings. The score after splitting a string is the number of zeros in the left substring plus the number of ones in the right substring.

=head1 USAGE

perl ch-2.pl

=head1 AUTHOR

Lubos Kolouch

=cut

=head1 FUNCTIONS

=head2 max_score

    my $score = max_score($str);

Returns the maximum score after splitting the string into two non-empty substrings.

=cut

sub max_score {
    my ($str) = @_;
    return 0 if length $str < 2;

    my $max_score = 0;

    # Iterate through all possible splits
    for my $i ( 1 .. length($str) - 1 ) {

        # Get left and right substrings
        my $left  = substr( $str, 0, $i );
        my $right = substr( $str, $i );

        # Count zeros in left
        my $zeros_left = () = $left =~ /0/g;

        # Count ones in right
        my $ones_right = () = $right =~ /1/g;

        # Compute score
        my $score = $zeros_left + $ones_right;

        # Update max score
        $max_score = $score if $score > $max_score;
    }

    return $max_score;
}

=head1 TESTS

=head2 Test Example 1

Input: $str = "0011"

Output: 4

=cut

is( max_score("0011"), 4, "Example 1: 0011 -> 4" );

=head2 Test Example 2

Input: $str = "0000"

Output: 3

=cut

is( max_score("0000"), 3, "Example 2: 0000 -> 3" );

=head2 Test Example 3

Input: $str = "1111"

Output: 3

=cut

is( max_score("1111"), 3, "Example 3: 1111 -> 3" );

=head2 Test Example 4

Input: $str = "0101"

Output: 3

=cut

is( max_score("0101"), 3, "Example 4: 0101 -> 3" );

=head2 Test Example 5

Input: $str = "011101"

Output: 5

=cut

is( max_score("011101"), 5, "Example 5: 011101 -> 5" );

done_testing;
