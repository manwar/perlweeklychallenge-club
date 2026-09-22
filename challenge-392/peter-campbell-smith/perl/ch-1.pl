#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-09-21
use utf8;     # Week 392 - task 1 - Convert palindrome
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

convert_palindrome('pinnipeds');
convert_palindrome('palindrome');
convert_palindrome('bananas');
convert_palindrome('dissident');
convert_palindrome('detartrated');

sub convert_palindrome {
	
	my ($string, $gnirts, $s, $j);
	
	# initialise
	$string = shift;
	$gnirts = reverse($string);
	$s = length($string);
	
	# seek matching substring
	for ($j = $s; $j > 0; $j --) {
		last if substr($string, 0, $j) eq substr($gnirts, -$j);
	}
	
	# report
	say qq[\nInput:  '$string'];
	say qq[Output: '] . substr($gnirts, 0, $s - $j) . $string . q['];
}
