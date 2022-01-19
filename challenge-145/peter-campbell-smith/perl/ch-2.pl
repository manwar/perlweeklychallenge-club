#!/usr/bin/perl

# Peter Campbell Smith - 2021-12-27
# PWC 145 task 2

use v5.20;
use warnings;
use strict;

# You are given a string $s.
# Write a script to create a Palindromic Tree for the given string.

# This produces the desired output, but not by explicitly using a palindromic tree,
# but the 'very_long' test is 1000 characters long and takes < 10sec on my 
# (quite slow) Raspberry Pi. The optimisation of is_palindromic to return false as 
# soon as it finds a mismatch helps a lot.

my (@strings, $string, $length, $sub_length, $start_at, $test, %seen, $very_long, $j);

# words
@strings = qw[redivider deific rotors challenge champion christmas 
	supercalifragilisticexpialidocious antidisestablishmentarianism abcdedcbfffffgfffffzz];

# add a random 1000-char string
$very_long = '';
for $j (0 ..999) {
	$very_long .= chr(ord('a') + rand(26));
}
push @strings, $very_long;

# loop over test strings
for $string (@strings) {
	print qq[\nInput:  $string\nOutput: ];
	%seen = ();
	
	# generate all possible substrings of $string
	$length = length($string);
	for $start_at (0 .. $length - 1) {
		for $sub_length (1 .. $length - $start_at) {
			
			# check if palindromic and not already seen
			$test = substr($string, $start_at, $sub_length);
			print qq[$test ] if (not $seen{$test} and is_palindromic($test));
			$seen{$test} = 1;
		}
	}
	say '';
}

sub is_palindromic {   #  ($string) and returns true/false if $string is/isn't palindromic

	my ($string, $string2, $gnirts);
	$string = $_[0];
	
	# compare 1st and last characters, and if the same, strip them off and repeat
	while ($string =~ s|^(.)(.*)(.)$|$2|g) {
		return 0 if $1 ne $3;
	}
	return 1;	
}
