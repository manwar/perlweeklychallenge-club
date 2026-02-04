#!/usr/bin/env perl
#
=head1 Task 2: String Reduction

Submitted by: Mohammad Sajid Anwar

You are given a word containing only alphabets, Write a function that
repeatedly removes adjacent duplicate characters from a string until no
adjacent duplicates remain and return the final word.

=head2 Example 1

    Input: $word = "aabbccdd"
    Output: ""

    Iteration 1: remove "aa", "bb", "cc", "dd" => ""

=head2 Example 2

    Input: $word = "abccba"
    Output: ""

    Iteration 1: remove "cc" => "abba"
    Iteration 2: remove "bb" => "aa"
    Iteration 3: remove "aa" => ""

=head2 Example 3

    Input: $word = "abcdef"
    Output: "abcdef"

    No duplicate found.

=head2 Example 4

    Input: $word = "aabbaeaccdd"
    Output: "aea"

    Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"

=head2 Example 5

    Input: $word = "mississippi"
    Output: "m"

    Iteration 1: Remove "ss", "ss", "pp" => "miiii"
    Iteration 2: Remove "ii", "ii" => "m"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [    "aabbccdd",       "", "Example 1"],
    [      "abccba",       "", "Example 2"],
    [      "abcdef", "abcdef", "Example 3"],
    [ "aabbaeaccdd",    "aea", "Example 4"],
    [ "mississippi",      "m", "Example 5"],
];

sub string_reduction
{
    my $word = shift;

    while ($word =~ s/(.)\1//g) {
        ;
    }

    return $word;
}

for (@$cases) {
    is(string_reduction($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
