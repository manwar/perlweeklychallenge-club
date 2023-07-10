#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-03
use utf8;     # Week 224 task 2 - Additive number
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($solution, @string, $j);

additive_number('12354782');
additive_number('199100199299498');
additive_number('0030047');
additive_number('314159');

# create a long one
@string = (28,74);;
for $j (0 .. 19) {
	push @string, $string[-1] + $string[-2];
}
additive_number(join('', @string));

sub additive_number {
	
	my $string;
	
	# initialise
	$solution = '';
	$string = shift @_;
	
	# start recursion
	test([], $string);
	
	# results
	say qq[\nInput:  \$string = '$string'];
	say qq[Output: ] . ($solution ? $solution : 'false');
}

sub test {
	
	# test 1 further number (maybe several digits) along $string
	
	my (@numbers, $string, $count, $length, $j, @new_numbers, $new_string, $keep_going);
	
	# we can stop if a solution has been found
	return if $solution;
	
	# initialise
	@numbers = @{$_[0]};
	$string = $_[1];
	$count = scalar @numbers;
	
	# if we have only 1 or 2 numbers they must be valid and we don't need to test them
	if ($count < 3) {
		$keep_going = 1;
	
	# we check that the last 3 numbers are additive, and if the string is now empty we have a solution
	} else {
		$keep_going = $numbers[-3] + $numbers[-2] == $numbers[-1];
		if ($keep_going and $string eq '') {
			$solution = join(', ', @numbers);
			return;
		}
	}
	
	# $keep_going is true if the sequence of @numbers is good but incomplete
	return unless $keep_going;
	
	# try using the next 1, 2, 3 ... digits from $string
	$length = length($string);
	for $j (1 .. $length) {
		@new_numbers = (@numbers, substr($string, 0, $j));
		$new_string = $j == $length ? '' : substr($string, $j);
		
		# and recurse with those
		test(\@new_numbers, $new_string);
	}
}
