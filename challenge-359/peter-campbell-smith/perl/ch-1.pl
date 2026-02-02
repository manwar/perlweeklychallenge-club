#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-02-02
use utf8;     # Week 359 - task 1 - Digital root
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

digital_root(1999999999);
digital_root(31415926535);
digital_root(10101010101010101);
digital_root(~0);
digital_root(1999999999999999999);
digital_root('99999999999999999999999999999999999999999999999999999999');
digital_root('19999999999999999999999');

sub digital_root {
	
	my ($root, $persist);
	
	# initialise
	$root = $_[0];
	$persist = 0;
	
	# add the digits ...
	do {
		$root = eval(join('+', split('', $root)));
		$persist ++;
		
	# ... until only one digit is left	
	} until $root <= 9;
	
	say qq[\nInput:  $_[0]];
	say qq[Output: additive persistence = $persist, ] .
		qq[digital root = $root];
}
