#!/usr/bin/env perl
#
=head1 Task 1: Good Strings

You are given a list of @words and a string $chars.

    A string is good if it can be formed by characters from $chars, each
    character can be used only once.

Write a script to return the sum of lengths of all good strings in words.

=head2 Example 1

	Input: @words = ("cat", "bt", "hat", "tree")
		   $chars = "atach"
	Output: 6

The good strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.

=head2 Example 2

	Input: @words = ("hello", "world", "challenge")
		   $chars = "welldonehopper"
	Output: 10

The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[["cat", "bt", "hat", "tree"],    "atach"],           6],
    [[["hello", "world", "challenge"], "welldonehopper"], 10],
];

sub good_strings
{
    my $words = $_[0]->[0];
    my $chars = $_[0]->[1];

    my $res = 0;
    WORDS: for my $w (@$words) {
        my %chars;
        $chars{$_}++ for split //, $chars;

        for my $c (split //, $w) {
            next WORDS if not defined $chars{$c} or $chars{$c} == 0;
            --$chars{$c};
        }
        $res += length($w);
    }
    return $res;
}

for (@$cases) {
    is(good_strings($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
