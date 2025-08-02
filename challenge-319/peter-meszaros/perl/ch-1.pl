#!/usr/bin/env perl
#
=head1 Task 1: Word Count

Submitted by: Mohammad Sajid Anwar

You are given a list of words containing alphabetic characters only.

Write a script to return the count of words either starting with a vowel or
ending with a vowel.

=head2 Example 1

    Input: @list = ("unicode", "xml", "raku", "perl")
    Output: 2

    The words are "unicode" and "raku".

=head2 Example 2

    Input: @list = ("the", "weekly", "challenge")
    Output: 2

=head2 Example 3

    Input: @list = ("perl", "python", "postgres")
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["unicode", "xml", "raku", "perl"], 2, "Example 1"],
    [["the", "weekly", "challenge"],     2, "Example 2"],
    [["perl", "python", "postgres"],     0, "Example 3"],
];

sub word_count
{
    my $words = shift;

    my $count = 0;
    for my $w (@$words) {
        ++$count if $w =~ /^[aeiou]/i || $w =~ /[aeiou]$/i;
    }
    return $count;
}

for (@$cases) {
    is(word_count($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
