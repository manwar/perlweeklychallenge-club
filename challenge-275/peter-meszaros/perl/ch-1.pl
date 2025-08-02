#!/usr/bin/env perl
#
=head1 Task 1: Broken Keys

You are given a sentence, $sentence and list of broken keys @keys.

Write a script to find out how many words can be typed fully.

=head2 Example 1

	Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
	Output: 0

=head2 Example 2

	Input: $sentence = "Perl and Raku", @keys = ('a')
	Output: 1

Only Perl since the other word two words contain 'a' and can't be typed fully.

=head2 Example 3

	Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
	Output: 2

=head2 Example 4

	Input: $sentence = "The joys of polyglottism", @keys = ('T')
	Output: 2

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[["Perl Weekly Challenge",    ['l', 'a']], 0],
	[["Perl and Raku",            ['a']],      1],
	[["Well done Team PWC",       ['l', 'o']], 2],
	[["The joys of polyglottism", ['T']],      2],
];

sub broken_keys
{
	my $s    = $_[0]->[0];
	my $keys = $_[0]->[1];

	my $cnt = 0;
	my %h;

	WORD: for my $w (split / /, $s) {
		for my $k (@$keys) {
			next WORD unless index(lc($w), lc($k)) < 0;
		}
		++$cnt;
    }

	return $cnt;

}

for (@$cases) {
    is(broken_keys($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
