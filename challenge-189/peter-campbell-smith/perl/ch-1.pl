#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-31
# PWC 189 task 1

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# You are given an array of characters (a..z) and a target character.
# Write a script to find out the smallest character in the given array lexicographically greater than the 
# target character.

# Blog: https://pjcs-pwc.blogspot.com/2022/10/the-smallest-greater-and-shortest-slice.html

my (@tests, $test, @array, $target, $k, @x);

@x = split('', 'thequickbrownfoxjumpsoverthelazydog');
@tests = ([qw/e m u g/], 'b', [qw/d c e f/], 'a', [qw/j a r/], 'o', [qw/d c a f/], 'a', [qw/t g a l/], 'v', 
	\@x, 'm');

# loop over tests
TEST: while ($tests[0]) {
	
	# get inputs
	@array = @{ shift @tests };
	$target = shift @tests;
	say qq[\nInput:  \@array = qw/] . join(' ', @array) . qq[/, \$target = '$target'];
	
	# sort the array and get the first character > $target
	for $k (sort @array) {
		next unless ($k gt $target);
		say qq[Output: $k];
		next TEST;
	}
	say qq[Output: none];
}
