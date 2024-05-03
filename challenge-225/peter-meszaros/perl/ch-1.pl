#!/usr/bin/env perl
#
=head1 Task 1: Max Words

You are given a list of sentences, @list.

    A sentence is a list of words that are separated by a single space with no leading or trailing spaces.

Write a script to find out the maximum number of words that appear in a single sentence.

=head2 Example 1

	Input: @list = ("Perl and Raku belong to the same family.",
					"I love Perl.",
					"The Perl and Raku Conference.")
	Output: 8

=head2 Example 2

	Input: @list = ("The Weekly Challenge.",
					"Python is the most popular guest language.",
					"Team PWC has over 300 members.")
	Output: 7

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["Perl and Raku belong to the same family.",
      "I love Perl.",
      "The Perl and Raku Conference."], 8],
    [["The Weekly Challenge.",
      "Python is the most popular guest language.",
      "Team PWC has over 300 members."], 7],
];

sub max_words
{
    my $l = shift;

    my $max_words = 0;
    for my $m (@$l) {
        my $n = split / /, $m;
        $max_words = $n if $n > $max_words;
    }
    return $max_words;
}

for (@$cases) {
    is(max_words($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
