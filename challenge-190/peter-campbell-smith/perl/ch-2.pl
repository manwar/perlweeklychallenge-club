#!/usr/bin/perl

# Peter Campbell Smith - 2022-11-07
# PWC 190 task 1

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# You are given a string consisting of a sequence of numeric characters: 0..9.  The string is a concatenation
# of encoded letters A-Z, where A = 1, B = 2 ... Z = 26. Write a script to find the all valid different decodings 
# in sorted order. Example: Input: $s = 11; Ouput: AA, K

# Blog: https://pjcs-pwc.blogspot.com/2022/11/capital-test-and-ambiguous-encoding.html

my (@tests, $base, $string, $answer, %answers, $test);

@tests = qw[11 1115 127 16518122051920];
$base = ord('A') - 1;   # so that we can convert a number to a character as $char = chr($base + $number)

# loop over tests
while ($test = shift @tests) {
	
	# analyse the input string
	say qq[\nInput:  $test];
	%answers = ();
	analyse('', $test);
	
	# format and output the answers
	$string = '';
	for $answer (sort keys %answers) {
		$string .= $answer . ', ';
	}
	say qq[Output: ] . substr($string, 0, -2);
}

sub analyse {
	
	my ($so_far, $test, $test_length, $first_two);
	
	# recursively tries taking the first 1 or 2 digits off test and adding them as a character to $so_far
	
	$so_far = $_[0];  # the character string so far
	$test = $_[1];    # the remaining digit string
	$test_length = length($test);
	return if substr($test, 0, 1) eq '0';   # won't happen for a valid $test
	
	# take the first digit of $test and add the corresponding character to so_far
	$so_far .= chr($base + substr($test, 0, 1));
	
	# if anything remains in $test, analyse(the new $so_far, the rest of $test)
	if ($test_length > 1) {
		analyse($so_far, substr($test, 1)) if length($test) > 1;
		
	# else we've exhausted $test and found an answer
	} else {
		$answers{$so_far} = 1;
		return;
	}
	
	# if $test is >= 2 digits and they are 10-26 then add them as a character to $so_far
	$so_far = $_[0];
	$first_two = substr($test, 0, 2);
	if ($test_length >= 2 and $first_two ge '10' and $first_two le '26') {
		$so_far .= chr($base + $first_two);
		
		# if anything remains in $test analyse(the new $so_far, the rest of $test)
		if (length($test) > 2) {
			analyse($so_far, substr($test, 2));
			
		# else we've exhausted $test and found an answer		
		} else {
			$answers{$so_far} = 1;
			return;
		}
	}
}
		
			
		
	
	

	
	
	
	
		
	

	

