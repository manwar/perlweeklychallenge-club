#!/usr/bin/env perl
#
=head1 Task 2: Find Anagrams

Submitted by: Mohammad Sajid Anwar

You are given a list of words, @words.

Write a script to find any two consecutive words and if they are anagrams, drop
the first word and keep the second. You continue this until there is no more
anagrams in the given list and return the count of final list.

=head2 Example 1

    Input: @words = ("acca", "dog", "god", "perl", "repl")
    Output: 3

    Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god" => ("acca", "god", "perl", "repl")
    Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl" => ("acca", "god", "repl")

=head2 Example 2

    Input: @words = ("abba", "baba", "aabb", "ab", "ab")
    Output: 2

    Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba" => ("baba", "aabb", "ab", "ab")
    Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb" => ("aabb", "ab", "ab")
    Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab" => ("aabb", "ab")

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["acca", "dog", "god", "perl", "repl"], 3, "Example 1"],
    [["abba", "baba", "aabb", "ab", "ab"],   2, "Example 2"],
];

sub find_anagrams
{
    my $words = shift;
    my @sorted = map { join '', sort split // } @$words;

    for my $i (0 .. $#$words-1) {
        if ($sorted[$i] eq $sorted[$i+1]) {
            $words->[$i] = undef;
        }
    }
    return scalar grep { defined } @$words;
}

for (@$cases) {
    is(find_anagrams($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
