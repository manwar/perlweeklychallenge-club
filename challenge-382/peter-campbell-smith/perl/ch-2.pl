#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/382/2

use v5.26;    # The Weekly Challenge - 2026-07-13
use utf8;     # Week 382 - task 2 - Replace question mark
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

replace_question_mark('01??0');
replace_question_mark('10101');
replace_question_mark('?0?0?');
replace_question_mark('');
replace_question_mark('???????');

sub replace_question_mark {

	my ($bits, $input, $j, $marks, $perm, $result, $this); 
	
	# initialise
	$input = $_[0];
	say qq[\nInput:  '$input'];
	$result = '';
	
	# count question marks and loop over possible 0/1 combinations
	$marks = $input =~ y|?|?|;
	for $perm (0 .. 2 ** $marks - 1) {
		
		# create binary 0/1 number with $marks digits
		$bits = sprintf("%.${marks}b", $perm);			
		
		# replace each ? with 0 or 1 from bits and save result
		$this = $input;
		$this =~ s|\?|substr($bits, $_, 1)|e for 0 .. $marks - 1;
		$result .= qq['$this', ];			
	}
	
	# report
	say qq[Output: ] . substr($result, 0, -2);
}
