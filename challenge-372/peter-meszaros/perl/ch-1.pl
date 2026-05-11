#!/usr/bin/env perl
#
=head1 Task 1: Rearrange Spaces

Submitted by: Mohammad Sajid Anwar

You are given a string text of words that are placed among number of spaces.
Write a script to rearrange the spaces so that there is an equal number of
spaces between every pair of adjacent words and that number is maximised. If
you can't distribute, place the extra speaces at the end. Finally return the
string.

=head2 Example 1

    Input: $str = "  challenge  "
    Output: "challenge    "

    We have 4 spaces and 1 word. So all spaces go to the end.

=head2 Example 2

    Input: $str = "coding  is  fun"
    Output: "coding  is  fun"

    We have 4 spaces and 3 words (2 gaps). So 2 spaces per gap.

=head2 Example 3

    Input: $str = "a b c  d"
    Output: "a b c d "

    We have 4 spaces and 4 words (3 gaps). So 1 space per gap and 1 remainder.

=head2 Example 4

    Input: $str = "  team      pwc  "
    Output: "team          pwc"

    We have 10 spaces and 2 words (1 gap). So 10 spaces per gap.

=head2 Example 5

    Input: $str = "   the  weekly  challenge  "
    Output: "the    weekly    challenge "

    We have 9 spaces and 3 words (2 gaps). So 4 spaces per gap and 1 remainder.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["  challenge  ",               "challenge    ",               "Example 1"],
    ["coding  is  fun",             "coding  is  fun",             "Example 2"],
    ["a b c  d",                    "a b c d ",                    "Example 3"],
    ["  team      pwc  ",           "team          pwc",           "Example 4"],
    ["   the  weekly  challenge  ", "the    weekly    challenge ", "Example 5"],
];

sub rearrange_spaces
{
    my $str = shift;

    my @words = split / +/, $str;
    shift @words if $words[0] eq '';
    my $spaces = () = $str =~ / /g;
    my $gaps = @words - 1;

    my ($per_gap, $remainder) = $gaps == 0 ? (0, $spaces) :
                                (int($spaces / $gaps), $spaces % $gaps);

    return join(' ' x $per_gap, @words) . (' ' x $remainder);
}

for (@$cases) {
    is(rearrange_spaces($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
