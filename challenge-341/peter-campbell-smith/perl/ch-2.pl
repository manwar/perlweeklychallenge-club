#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-09-29
use utf8;     # Week 341 - task 2 - Reverse prefix
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

reverse_prefix('programming', 'g');
reverse_prefix('hello', 'h');
reverse_prefix('goodbye', 'e');
reverse_prefix('noitulos', 's');
reverse_prefix('conundrum', 'z');

sub reverse_prefix {
	
	my ($string, $char, $result);
	
	# initialise
	($string, $char) = @_;
	
	# do as instructed
	if ($string =~ m|(.*?)$char(.*)|) {
		$result = qq['$char] . reverse($1) . qq[$2'];
		
	# non-compliant data!	
	} else {
		$result = qq[There is no '$char' in '$string'];
	}
		
	say qq[\nInput:  \$string = '$string', \$char = '$char'];
	say qq[Output: $result];
}
