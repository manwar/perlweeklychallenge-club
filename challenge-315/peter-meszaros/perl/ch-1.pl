#!/usr/bin/env perl
#
=head1 Task 1: Find Words

Submitted by: Mohammad Sajid Anwar

You are given a list of words and a character.

Write a script to return the index of word in the list where you find the given
character.

=head2 Example 1

    Input: @list = ("the", "weekly", "challenge")
           $char = "e"
    Output: (0, 1, 2)

=head2 Example 2

    Input: @list = ("perl", "raku", "python")
           $char = "p"
    Output: (0, 2)

=head2 Example 3

    Input: @list = ("abc", "def", "bbb", "bcd")
           $char = "b"
    Output: (0, 2, 3)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[["the", "weekly", "challenge"], "e"], [0, 1, 2], "Example 1"],
    [[["perl", "raku", "python"],     "p"], [0, 2],    "Example 2"],
    [[["abc", "def", "bbb", "bcd"],   "b"], [0, 2, 3], "Example 3"],
];

sub find_words
{
    my $list = $_[0]->[0];
    my $char = $_[0]->[1];

    return [grep { index($list->[$_], $char) > -1 ? ($_ + 1) : 0 } 0 .. $#$list];
}

for (@$cases) {
    is(find_words($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
