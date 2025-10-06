#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-10-06
use utf8;     # Week 342 - task 1 - Balance string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

balance_string('a0b1c2');
balance_string('abc12');
balance_string('0a2b1c3');
balance_string('1a23');
balance_string('ab123');
balance_string('theweeklychallenge987654321098765432');
balance_string('');
balance_string('z');
balance_string('9');

sub balance_string {
	
	my (@symbols, @letters, @numbers, $c, $result, $diff, $paired);
	
	# sort string
	@symbols = sort(split('', $_[0]));
	@numbers = @letters = ();
	
	# separate numbers and letters
	for $c (@symbols) {
		if ($c lt 'a') { push(@numbers, $c) }
		else           { push(@letters, $c) }
	}
	
	# create result
	$diff = @letters - @numbers;
	if (abs($diff) <= 1 and @symbols) {
		$paired = $diff < 0 ? @letters : @numbers;
		$result  = shift(@letters) if $diff == 1;
		$result .= shift(@numbers) . shift(@letters) for 1 .. $paired;
		$result .= shift(@numbers) if $diff == -1;
	} else {
		$result = '';
	}
	
	say qq[\nInput:  '$_[0]'];
	say qq[Output: '$result'];
}
