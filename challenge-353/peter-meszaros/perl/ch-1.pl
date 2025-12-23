#!/usr/bin/env perl
#
=head1 Task 1: Max Words

Submitted by: Mohammad Sajid Anwar

You are given an array of sentences.

Write a script to return the maximum number of words that appear in a single
sentence.

=head2 Example 1

    Input: @sentences = ("Hello world", "This is a test", "Perl is great")

    Output: 4

=head2 Example 2

    Input: @sentences = ("Single")

    Output: 1

=head2 Example 3

    Input: @sentences = ("Short", "This sentence has seven words in total", "A
    B C", "Just four words here")

    Output: 7

=head2 Example 4

    Input: @sentences = ("One", "Two parts", "Three part phrase", "")

    Output: 3

=head2 Example 5

    Input: @sentences = ("The quick brown fox jumps over the lazy dog", "A",
    "She sells seashells by the seashore", "To be or not to be that is the
    question")

    Output: 10

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["Hello world", "This is a test", "Perl is great"],
        4, "Example 1"],
    [["Single"],
        1, "Example 2"],
    [["Short", "This sentence has seven words in total",
      "A B C", "Just four words here"],
        7, "Example 3"],
    [["One", "Two parts", "Three part phrase", ""],
        3, "Example 4"],
    [["The quick brown fox jumps over the lazy dog", "A",
      "She sells seashells by the seashore",
      "To be or not to be that is the question"],
       10, "Example 5"],
];

sub max_words
{
    my $sents = shift;
    my $max = 0;
    for my $s (@$sents) {
        my $count = split /\s+/, $s;
        $max = $count if $count > $max;
    }
    return $max;
}

for (@$cases) {
    is(max_words($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
