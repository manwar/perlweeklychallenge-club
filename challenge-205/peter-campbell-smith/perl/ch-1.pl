#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-20

use v5.28;
use utf8;
use warnings;
use List::Uniq ':all';

# Task: You are given an array of integers. Write a script to find the 
# third highest value in the array.

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/205/1

my (@test, $j);

third_highest(5, 3, 4);
third_highest(5, 6);
third_highest(5, 4, 4, 3);
third_highest(-3, -2, -1);
third_highest(1, 1, 1, 1, 1);
third_highest();

# make a longer example - 100 random numbers in (0 .. 999)
for $j (0 .. 99) {
	$test[$j] = int(rand(1000));
}
third_highest(@test);

sub third_highest {
	
	# find the 3rd highest value in the argument list
	my (@array, $result, $count);
	
	# get the unique values in the list and sort them largest to smallest
	@array = sort {$b <=> $a} uniq(@_);
	$count = scalar @array;
	
	# select appropriate legend
	if ($count >= 3) {
		$result = qq[First highest is $array[0]. Second highest is $array[1]. Third highest is $array[2].];
	} elsif ($count == 2) {
		$result = qq[First highest is $array[0]. Second highest is $array[1]. Third highest is missing so maximum is returned.];
	} elsif ($count == 1) {
		$result = qq[First highest is $array[0]. Second and third highest are missing so maximum is returned.];
	} else {
		$result = 'List is empty.';
	}

	say qq[\nInput:  \@array = (] . join (', ', @_) . ')' . qq[\nOutput: $result];
}

	

