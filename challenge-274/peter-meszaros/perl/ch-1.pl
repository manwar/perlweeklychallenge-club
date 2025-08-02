#!/usr/bin/env perl
#
=head1 Task 1: Goat Latin

You are given a sentence, $sentance.

Write a script to convert the given sentence to Goat Latin, a made up language
similar to Pig Latin.

Rules for Goat Latin:

1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
"ma" to the end of the word.

2) If a word begins with consonant i.e. not a vowel, remove first
letter and append it to the end then add "ma".

3) Add letter "a" to the end of first word in the sentence, "aa" to
the second word, etc etc.

=head2 Example 1

	Input: $sentence = "I love Perl"
	Output: "Imaa ovelmaaa erlPmaaaa"

=head2 Example 2

	Input: $sentence = "Perl and Raku are friends"
	Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"

=head2 Example 3

	Input: $sentence = "The Weekly Challenge"
	Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	["I love Perl",
     "Imaa ovelmaaa erlPmaaaa",                            "Example 1"],
	["Perl and Raku are friends",
     "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa", "Example 2"],
	["The Weekly Challenge",
     "heTmaa eeklyWmaaa hallengeCmaaaa",                   "Example 3"],
];

sub goat_latin
{
	my $s = shift;

    my $n = 1;
	my @s;
	for my $w (split / /, $s) {
		unless ($w =~ /^[aeiou]/i) {
			$w = substr($w, 1) . substr($w, 0, 1);
		}
		push @s, $w . 'ma' . ('a' x $n++);
	}
	return join(' ', @s);
}

for (@$cases) {
    is(goat_latin($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
