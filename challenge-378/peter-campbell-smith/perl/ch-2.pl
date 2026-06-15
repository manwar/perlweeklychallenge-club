#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-15
use utf8;     # Week 378 - task 2 - Sum of words
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

sum_of_words('abc', 'def', 'dfh');
sum_of_words('cde', 'fgh', 'aaaaa');
sum_of_words('deaf', 'bedfig', 'begjjb');
sum_of_words('aab', 'aaac', 'aaaaad');
sum_of_words('jjj', 'aaa', 'jjj');
sum_of_words('a', 'jjj', 'h');

sub sum_of_words {
	
	my (@string, @number);
	
	# initialise
	@string = @_;
	say qq[\nInput:  ('$string[0]', '$string[1]', '$string[2]')];
	
	# check for truth
	$number[$_] = number($string[$_]) for 0 .. 2;
	say qq[Output: ] . ($number[2] == ($number[0] + $number[1]) ? 
		'true' : 'false');
	
	# 'proof'
	say qq[        $number[0] + $number[1] = ] .
		($number[0] + $number[1]) . qq[ versus $number[2]];
}

sub number {
	
	# converts string to integer (a -> 0 ... j -> 9)
	my $n = 0;
	$n = $n * 10 + ord($_) - ord('a')  for split(//, $_[0]);
	return $n;
}
