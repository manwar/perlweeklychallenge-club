#!/usr/bin/env perl
#
=head1 Task 1: Common Characters

Submitted by: Mohammad Sajid Anwar

You are given an array of words.

Write a script to return all characters that is in every word in the given
array including duplicates.

=head2 Example 1

    Input: @words = ("bella", "label", "roller")
    Output: ("e", "l", "l")

=head2 Example 2

    Input: @words = ("cool", "lock", "cook")
    Output: ("c", "o")

=head2 Example 3

    Input: @words = ("hello", "world", "pole")
    Output: ("l", "o")

=head2 Example 4

    Input: @words = ("abc", "def", "ghi")
    Output: ()

=head2 Example 5

    Input: @words = ("aab", "aac", "aaa")
    Output: ("a", "a")

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["bella", "label", "roller"], ["e", "l", "l"], "Example 1"],
    [["cool", "lock", "cook"],     ["c", "o"],      "Example 2"],
    [["hello", "world", "pole"],   ["l", "o"],      "Example 3"],
    [["abc", "def", "ghi"],        [],              "Example 4"],
    [["aab", "aac", "aaa"],        ["a", "a"],      "Example 5"],
];

sub common_characters
{
    my $words = shift;

    my %char_count;
    foreach my $word (@$words) {
        $char_count{$_}++ foreach (split //, $word);
    }

    my @common_chars;
    foreach my $char (sort keys %char_count) {
        my $min_count = $char_count{$char};
        foreach my $word (@$words) {
            my $count = () = $word =~ /$char/g;
            $min_count = $count if $count < $min_count;
        }
        push @common_chars, ($char) x $min_count if $min_count > 0;
    }
    return \@common_chars;
}

for (@$cases) {
    is(common_characters($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
