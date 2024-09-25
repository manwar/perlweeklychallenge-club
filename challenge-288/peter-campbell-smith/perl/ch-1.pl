#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-23
use utf8;     # Week 288 - task 1 - Closest palindrome
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

closest_palindrome(5);
closest_palindrome(123);
closest_palindrome(1001);
closest_palindrome(1400);
closest_palindrome(987654321);
closest_palindrome(int(rand(10000000000)));

sub closest_palindrome {
	
	my ($less, $more, $j, $test);
	
	# start counting at $str ± 1
	$less = $_[0] - 1;
	$more = $less + 2;
	
	# loop outwards from $str
	for $j (1 .. $less) {
		$test = reverse($less);
		last if $test eq $less --;
		$test = reverse($more);
		last if $test eq $more ++;
	}
	
	say qq[\nInput:  \$str = '$_[0]'];
	say qq[Output:        '$test'];
}
