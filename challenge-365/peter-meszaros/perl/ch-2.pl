#!/usr/bin/env perl
#
=head1 Task 2: Valid Token Counter

Submitted by: Mohammad Sajid Anwar

You are given a sentence.  Write a script to split the given sentence into
space-separated tokens and count how many are valid words. A token is valid if
it contains no digits, has at most one hyphen surrounded by lowercase letters,
and at most one punctuation mark (!, ., ,) appearing only at the end.

=head2 Example 1

    Input: $str = "cat and dog"
    Output: 3

    Tokens: "cat", "and", "dog"

=head2 Example 2

    Input: $str = "a-b c! d,e"
    Output: 2

    Tokens: "a-b", "c!", "d,e"
    "a-b" -> valid (one hyphen between letters)
    "c!"  -> valid (punctuation at end)
    "d,e" -> invalid (punctuation not at end)

=head2 Example 3

    Input: $str = "hello-world! this is fun"
    Output: 4

    Tokens: "hello-world!", "this", "is", "fun"
    All satisfy the rules.

=head2 Example 4

    Input: $str = "ab- cd-ef gh- ij!"
    Output: 2

    Tokens: "ab-", "cd-ef", "gh-", "ij!"
    "ab-"   -> invalid (hyphen not surrounded by letters)
    "cd-ef" -> valid
    "gh-"   -> invalid
    "ij!"   -> valid

=head2 Example 5

    Input: $str = "wow! a-b-c nice."
    Output: 2

    Tokens: "wow!", "a-b-c", "nice."
    "wow!"  -> valid
    "a-b-c" -> invalid (more than one hyphen)
    "nice." -> valid

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [             "cat and dog", 3, 'Example 1'],
    [              "a-b c! d,e", 2, 'Example 2'],
    ["hello-world! this is fun", 4, 'Example 3'],
    [       "ab- cd-ef gh- ij!", 2, 'Example 4'],
    [        "wow! a-b-c nice.", 2, 'Example 5'],
];

sub valid_token_counter
{
    my $str = shift;

    my $count = 0;
    for my $token (split /\s+/, $str) {
        ++$count if $token =~ /^[a-z]+(-[a-z]+)?[!.,]?$/;
    }
    return $count;
}

for (@$cases) {
    is(valid_token_counter($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
