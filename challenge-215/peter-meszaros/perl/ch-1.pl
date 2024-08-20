#!/usr/bin/env perl
#
=head1 Task 1: Odd one Out

Submitted by: Mohammad S Anwar

You are given a list of words (alphabetic characters only) of same size.

Write a script to remove all words not sorted alphabetically and print the
number of words in the list that are not alphabetically sorted.

=head2 Example 1

	Input: @words = ('abc', 'xyz', 'tsu')
	Output: 1

	The words 'abc' and 'xyz' are sorted and can't be removed.
	The word 'tsu' is not sorted and hence can be removed.

=head2 Example 2

	Input: @words = ('rat', 'cab', 'dad')
	Output: 3

	None of the words in the given list are sorted.
	Therefore all three needs to be removed.

=head2 Example 3

	Input: @words = ('x', 'y', 'z')
	Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[['abc', 'xyz', 'tsu'], 1, 'Example 1'],
	[['rat', 'cab', 'dad'], 3, 'Example 2'],
	[['x', 'y', 'z'],       0, 'Example 3'],
];

sub odd_one_out
{
    my $l = shift;

    my $cnt = 0;
    for my $w (@$l) {
        ++$cnt unless join('', sort (split '', $w)) eq $w;
    }
    return $cnt;
}

for (@$cases) {
    is(odd_one_out($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
