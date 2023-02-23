#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use List::MoreUtils qw(uniq);
use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

	Week 205:

	Task 2: Maximum XOR
	Submitted by: Mohammad S Anwar
	You are given an array of integers.

	Write a script to find the highest value obtained by XORing any two distinct members of the array.

	Example 1
	Input: @array = (1,2,3,4,5,6,7)
	Output: 7

	The maximum result of 1 xor 6 = 7.
	Example 2
	Input: @array = (2,4,1,3)
	Output: 7

	The maximum result of 4 xor 3 = 7.
	Example 3
	Input: @array = (10,5,7,12,8)
	Output: 15

	The maximum result of 10 xor 5 = 15.

=cut


is(MaximumXor(1,2,3,4,5,6,7), 7, 'Test Case 1.');
is(MaximumXor(2,4,1,3), 7, 'Test Case 2.');
is(MaximumXor(10,5,7,12,8), 15, 'Test Case 3.');

sub MaximumXor {
	my @array = @_;

	my $max_xor = 0;
	my $array_size = scalar @array;

	for (my $i = 0; $i < $array_size; $i++) {
		for (my $j = $i + 1; $j < $array_size; $j++) {
			my $current_xor = $array[$i] ^ $array[$j];
			$max_xor = $current_xor if $current_xor > $max_xor
		}
	}

	return $max_xor;
}

done_testing();
