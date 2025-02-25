#!/usr/bin/env perl
#
=head1 Task 1: Replace Words

Submitted by: Mohammad Sajid Anwar

You are given an array of words and a sentence.

Write a script to replace all words in the given sentence that start with any
of the words in the given array.

=head2 Example 1

    Input: @words = ("cat", "bat", "rat")
           $sentence = "the cattle was rattle by the battery"
    Output: "the cat was rat by the bat"

=head2 Example 2

    Input: @words = ("a", "b", "c")
           $sentence = "aab aac and cac bab"
    Output: "a a a c b"

=head2 Example 3

    Input: @words = ("man", "bike")
           $sentence = "the manager was hit by a biker"
    Output: "the man was hit by a bike"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[['cat', 'bat', 'rat'], 'the cattle was rattle by the battery'], 'the cat was rat by the bat', 'Example 1'],
    [[['a',   'b',   'c'],   'aab aac and cac bab'],                  'a a a c b',                  'Example 2'],
    [[['man', 'bike'],       'the manager was hit by a biker'],       'the man was hit by a bike',  'Example 3'],
];

sub replace_words
{
    my $words    = $_[0]->[0];
    my $sentence = $_[0]->[1];

    my @sentence = split / /, $sentence;
    for my $s (@sentence) {
        for my $w (@$words) {
            $s = $w if $s =~ /^$w/;
        }
    }

    return join ' ', @sentence;
}

for (@$cases) {
    is(replace_words($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
