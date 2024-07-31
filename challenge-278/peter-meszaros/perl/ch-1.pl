#!/usr/bin/env perl
#
=head1 Task 1: Sort String

Submitted by: Mohammad Sajid Anwar

You are given a shuffle string, $str.

Write a script to return the sorted string.

	A string is shuffled by appending word position to each word.

=head2 Example 1

	Input: $str = "and2 Raku3 cousins5 Perl1 are4"
	Output: "Perl and Raku are cousins"

=head2 Example 2

	Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
	Output: "Python is the most popular guest language"

=head2 Example 3

	Input: $str = "Challenge3 The1 Weekly2"
	Output: "The Weekly Challenge"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	["and2 Raku3 cousins5 Perl1 are4",
     "Perl and Raku are cousins"],
	["guest6 Python1 most4 the3 popular5 is2 language7",
     "Python is the most popular guest language"],
	["Challenge3 The1 Weekly2",
     "The Weekly Challenge"],
];

sub sort_string
{
	my $str = shift;
	
	my @str = split(/ /, $str);
	@str = sort { substr($a, -1, 1) <=> substr($b, -1, 1) } @str;
    return join(' ',  map { substr($_, 0, -1) } @str);
}

for (@$cases) {
    is(sort_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
