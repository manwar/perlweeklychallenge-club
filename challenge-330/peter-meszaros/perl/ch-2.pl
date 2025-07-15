#!/usr/bin/env perl
#
=head1 Task 2: Title Capital

Submitted by: Mohammad Sajid Anwar

You are given a string made up of one or more words separated by a single
space.

Write a script to capitalise the given title. If the word length is 1 or 2 then
convert the word to lowercase otherwise make the first character uppercase and
remaining lowercase.

=head2 Example 1

    Input: $str = "PERL IS gREAT"
    Output: "Perl is Great"

=head2 Example 2

    Input: $str = "THE weekly challenge"
    Output: "The Weekly Challenge"

=head2 Example 3

    Input: $str = "YoU ARE A stAR"
    Output: "You Are a Star"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["PERL IS gREAT",        "Perl is Great",        "Example 1"],
    ["THE weekly challenge", "The Weekly Challenge", "Example 2"],
    ["YoU ARE A stAR",       "You Are a Star",       "Example 3"],
];

sub title_capital
{
    my $str = shift;
    my @words = split /\s+/, $str;

    for my $word (@words) {
        $word = lc($word);
        if (length($word) > 2) {
            $word = ucfirst($word);
        }
    }

    return join(' ', @words);
}

for (@$cases) {
    is(title_capital($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
