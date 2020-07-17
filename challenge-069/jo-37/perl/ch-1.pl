#!/usr/bin/perl

use Test2::V0;
use List::Util qw(reduce);

# Cartesian/outer product of left and right array as string concatenation.
# (Reusing the code from challenge 067.)
sub prod {
	my ($left, $right) = @_;
	[map {my $l = $_; map $l . $_, @$right} @$left];
}

# generate all strobogrammatic numbers of a given length
sub all_for_length {
	my $length = shift;
	return (0, 1, 8) if $length == 1;

	# generate heads without leading zero
	# (Again taken from challenge 067, here utilizing List::Util's
	# special behaviour when called with only one element.)
	my $heads = reduce {prod $a, [0, 1, 6, 8, 9]}
		[1, 6, 8, 9], (1 .. $length/2 - 1);

	# complete the heads by:
	# - adding middle digits (or a dummy for even lengths)
	# - adding the respective tail
	# - removing any middle dummies
	map y/X//dr, map {$_ . substr reverse(y/69/96/r), 1}
		@{prod $heads, $length % 2 == 0 ? ['X'] : [0, 1, 8]};
}

# Task 1: generate strobogrammatic numbers in given range
sub strobogrammatic_numbers {
	my ($from, $to) = @_;
	
	# generate numbers for all possible lengths
	# and then filter values in range
	grep {$_ >= $from && $_ <= $to}
		map {all_for_length $_} (length($from) .. length($to));
}

is [strobogrammatic_numbers(50, 100)], [69, 88, 96], 'example from challenge';
is [strobogrammatic_numbers(0, 9999)], [0, 1, 8, 11, 69, 88, 96, 101, 111,
	181, 609, 619, 689, 808, 818, 888, 906, 916, 986, 1001, 1111, 1691,
	1881, 1961, 6009, 6119, 6699, 6889, 6969, 8008, 8118, 8698, 8888, 8968,
	9006, 9116, 9696, 9886, 9966], 'taken from wikipedia';

done_testing;
