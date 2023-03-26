#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use List::Util qw( max );
use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

	Week 208:

	Task 1: Minimum Index Sum
	Submitted by: Mohammad S Anwar
	You are given two arrays of strings.

	Write a script to find out all common strings in the given two arrays with minimum index sum. If no common strings found returns an empty list.

	Example 1
	Input: @list1 = ("Perl", "Raku", "Love")
		@list2 = ("Raku", "Perl", "Hate")

	Output: ("Perl", "Raku")

	There are two common strings "Perl" and "Raku".
	Index sum of "Perl": 0 + 1 = 1
	Index sum of "Raku": 1 + 0 = 1
	Example 2
	Input: @list1 = ("A", "B", "C")
		@list2 = ("D", "E", "F")

	Output: ()

	No common string found, so no result.
	Example 3
	Input: @list1 = ("A", "B", "C")
		@list2 = ("C", "A", "B")

	Output: ("A")

	There are three common strings "A", "B" and "C".
	Index sum of "A": 0 + 1 = 1
	Index sum of "B": 1 + 2 = 3
	Index sum of "C": 2 + 0 = 2

=cut

is(MinimumIndexSum(["Perl", "Raku", "Love"], ["Raku", "Perl", "Hate"]), ["Raku", "Perl"], 'Test Case 1.');
is(MinimumIndexSum(["A", "B", "C"], ["D", "E", "F"]), [], 'Test Case 2.');
is(MinimumIndexSum(["A", "B", "C"], ["C", "A", "B"]), ["A"], 'Test Case 3.');

sub MinimumIndexSum {
	my ($list1, $list2) = @_;

	my $list1_size = scalar(@{$list1});
	my $list2_size = scalar(@{$list2});

	if ($list2 > $list1) {
		($list1, $list2) = ($list2, $list1);
		($list1_size, $list2_size) = ($list2_size, $list1_size);
	}

	my %list1_hash = ();
	my $index = 0;
	my $minimum_index_sum = List::Util::max($list1_size, $list2_size);
	my @common_strings = ();

	foreach (@{$list1}) {
		$list1_hash{$_} = $index;
		$index += 1;
	}

	for (my $i = 0; $i < $list2_size; $i++) {
		my $list2_string = $list2->[$i];
		my $list1_index = $list1_hash{$list2_string};

		if (defined $list1_index) {
			my $index_sum = $i + $list1_index;

			if ($index_sum <= $minimum_index_sum) {
				$minimum_index_sum = $index_sum;
				push @common_strings, $list2_string;
			}
		}
	}

	return \@common_strings;
}

done_testing();
