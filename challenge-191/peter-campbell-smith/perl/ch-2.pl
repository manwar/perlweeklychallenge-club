#!/usr/bin/perl

# Peter Campbell Smith - 2022-11-14
# PWC 191 task 1

use v5.28;
use utf8;
use warnings;

# You are given an integer, 0 < $n <= 15. Write a script to find the number of orderings of numbers that form 
# a cute list. With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list is cute if for 
# every entry, indexed with a base of 1, either $list[$i] is evenly divisible by $i or  $i is evenly divisible 
# by $list[$i]

# Blog: https://pjcs-pwc.blogspot.com/2022/11/the-twice-largest-and-number-of-cuties.html

my ($n, @perm, $nn, $x, $cute);

# loop over possible values of $n
for $nn (1 .. 15) {
	@perm = (0);
	$n = $nn;
	$cute = 0;
	@perm = find_cute(@perm);
	shift @perm;
	say qq[cute[$nn] = $cute];
}

sub find_cute {   # (@perm)

	# finds all the possible cute sublists comprising @perm and one additional digit
	# or returns if the list is complete
	
	my ($next_index, @perm, $j, $i, @used);
	
	# initialise
	@perm = @_;
	$next_index = scalar(@perm);
	
	# if we have enough digits, increement the cute count and return
	if ($next_index > $n) {
		$cute ++;
		return;
	}

	# set $used[$i] to 1 if $i has already been used in the string
	for $i (1 .. $n) {
		$used[$i] = 0;
	}
	for $i (1 .. $next_index) {
		if (defined($perm[$i])) {
			$used[$perm[$i]] = 1;
		}
	}

	# check whether adding each unused factor and multiple of the index will work as the next element
	for $j (1 .. $n) {
		if (not $used[$j] and ($next_index % $j == 0 or $j % $next_index == 0)) {
			find_cute(@perm, $j);				
		}
	}	
}
