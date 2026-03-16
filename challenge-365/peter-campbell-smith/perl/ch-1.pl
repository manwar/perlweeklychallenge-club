#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-16
use utf8;     # Week 365 - task 1 - Alphabet index digit sum
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

alphabet_index_digit_sum('abc', 1);
alphabet_index_digit_sum('az', 2);
alphabet_index_digit_sum('perl', 3);
alphabet_index_digit_sum('supercalifragilisticexpialidocious', 3);
alphabet_index_digit_sum('', 6);

sub alphabet_index_digit_sum {
	
	my ($string, $count, $a, $sum, @digits, $d);
	
	# initialise
	($string, $count) = @_;
	$a = ord('a') - 1;
	
	# convert string to digits
	$string =~ s|([a-z])|ord($1) - $a|ge;
	
	# sum repeatedly
	for (1 .. $count) {
		@digits = split(//, $string);
		$string = '';
		$sum = 0;
		$sum += $_ for @digits;
		$string .= $sum;
	}
	
	# report
	say qq[\nInput:  \$str = '$_[0]', \$k = $count];
	say qq[Output: ] . ($sum + 0);
}
