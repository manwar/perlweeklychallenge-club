#!/usr/bin/env perl
#
=head1 Task 2: Word Sorter

Submitted by: Mohammad Sajid Anwar

You are give a sentence.  Write a script to order words in the given sentence
alphabetically but keeps the words themselves unchanged.

=head2 Example 1

    Input: $str = "The quick brown fox"
    Output: "brown fox quick The"

=head2 Example 2

    Input: $str = "Hello    World!   How   are you?"
    Output: "are Hello How World! you?"

=head2 Example 3

    Input: $str = "Hello"
    Output: "Hello"

=head2 Example 4

    Input: $str = "Hello, World! How are you?"
    Output: "are Hello, How World! you?"

=head2 Example 5

    Input: $str = "I have 2 apples and 3 bananas!"
    Output: "2 3 and apples bananas! have I"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["The quick brown fox",              "brown fox quick The",            "Example 1"],
    ["Hello    World!   How   are you?", "are Hello How World! you?",      "Example 2"],
    ["Hello",                            "Hello",                          "Example 3"],
    ["Hello, World! How are you?",       "are Hello, How World! you?",     "Example 4"],
    ["I have 2 apples and 3 bananas!",   "2 3 and apples bananas! have I", "Example 5"],
];

sub word_sorter
{
    my $str = shift;
    my @words = split /\s+/, $str;
    return join ' ', sort {lc($a) cmp lc($b)} @words;
}

for (@$cases) {
    is(word_sorter($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
