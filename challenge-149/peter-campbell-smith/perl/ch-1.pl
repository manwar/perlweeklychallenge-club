#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-24
# PWC 149 task 2

use v5.28;
use strict;
use warnings;
use utf8;

# Given an input $n, generate the first $n numbers for which the sum of their digits is a Fibonacci number.

# Note: eval(join('+', split(//, $i))) splits $i into individual digits, joins them with '+' signs and 
# evaluates the resulting sum of the digits.

my ($n, $i, @fibs, @results);

$n = 20;

@fibs = (0, 1);   # initial fibonacci series
@results = ();

# count up until we have the required quantity of results
for ($i = 0; $#results < $n - 1; $i++) {
	push(@results, $i) if is_a_fib(eval(join('+', split(//, $i))));   # see note above
}

say qq[f($n) = (] . join(', ', @results) . ')';

sub is_a_fib {
	
	# returns true if the argument is a fibonacci number
	
	my ($arg, $i);
	$arg = $_[0];
	
	# make sure @fibs is long enough
	while ($arg > $fibs[$#fibs]) {
		$fibs[$#fibs + 1] = $fibs[$#fibs] + $fibs[$#fibs - 1];   # add one fib to @fibs
	}
	
	# check if $arg is in @fibs (binary chop would be faster but why bother?)
	for ($i = $#fibs; $i >= 0; $i--) {
		return 1 if $arg == $fibs[$i];
	}
	return 0;
}
		


