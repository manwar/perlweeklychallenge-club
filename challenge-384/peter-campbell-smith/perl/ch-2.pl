#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/384/2

use v5.26;    # The Weekly Challenge - 2026-07-27
use utf8;     # Week 384 - task 2 - Special binary substrings
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

special_binary_substrings('0101');
special_binary_substrings('000111');
special_binary_substrings('000011');
special_binary_substrings('101');
special_binary_substrings('');
special_binary_substrings('1111111');

# longer example
my $z;
$z .= int(rand(2)) for 1 .. 500;
special_binary_substrings($z);

sub special_binary_substrings {
	
	my ($string, $test0, $test1, $result);
	
	# initialise
	$string = shift;
	say qq[\nInput:  '$string'];
	$test0 = $test1 = '';

	# check for 01, 10, 0011, 1100 ...
	while (length($test0) < length($string)) {
		$test0 = '0' . $test0 . '1';
		$test1 = '1' . $test1 . '0';
		$result .= qq['$test0', ] if $string =~ m|$test0|;
		$result .= qq['$test1', ] if $string =~ m|$test1|;
	}

	say qq[Output: ] . ($result ? substr($result, 0, -2) : 'none');
}
