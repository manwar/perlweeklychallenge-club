#!/usr/bin/env perl
#
=head1 Task 2: Reverse Word

Submitted by: Mohammad Sajid Anwar

You are given a word, $word and a character, $char.

Write a script to replace the substring up to and including $char with its
characters sorted alphabetically. If the $char doesn't exist then DON'T do
anything.

=head2 Example 1

	Input: $str = "challenge", $char = "e"
	Ouput: "acehllnge"

=head2 Example 2

	Input: $str = "programming", $char = "a"
	Ouput: "agoprrmming"

=head2 Example 3

	Input: $str = "champion", $char = "b"
	Ouput: "champion"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[ "challenge",   "e"], "acehllnge"],
	[[ "programming", "a"], "agoprrmming"],
	[[ "champion",    "b"], "champion"],
];

sub reverse_word
{
	my $w = $_[0]->[0];
	my $c = $_[0]->[1];

    $w =~ s/^([a-z]+?${c})/join '', sort split '', $1/e;	
    return $w;
}

for (@$cases) {
    is(reverse_word($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

