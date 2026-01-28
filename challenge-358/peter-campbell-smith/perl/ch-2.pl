#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-01-26
use utf8;     # Week 358 - task 2 - Encrypted string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

encrypted_string('abc', 1);
encrypted_string('xyz', 2);
encrypted_string('abc', 27);
encrypted_string('supercalifragilisticexpialidocious', 2601);
encrypted_string('perl', 26);

sub encrypted_string {
	
	my (@chars, $length, $shift, $encrypted, $j, $k);
	
	# initialise
	@chars = split('', lc($_[0]));
	$length = $#chars;
	$shift = $_[1];
	$encrypted = '';
	
	# encrypt
	for $j (0 .. $length) {
		$k = ord($chars[$j]) - ord('a');
		$k = ($k + $shift) % 26;
		$k += ord('a');
		$encrypted .= chr($k);
	}
	
	# report
	say qq[\nInput:  \$str = '] . join('', @chars) . 
		qq[', \$int = $shift];
	say qq[Output: '$encrypted'];
}
