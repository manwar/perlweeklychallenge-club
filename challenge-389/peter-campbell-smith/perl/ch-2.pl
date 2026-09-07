#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/389/2

use v5.26;    # The Weekly Challenge - 2026-08-31
use utf8;     # Week 389 - task 2 - Zigzag subarray
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

zigzag_subarray(9, 4, 2, 10, 7, 8, 8, 1, 9);
zigzag_subarray(1, 7, 4, 9, 2, 5);
zigzag_subarray(1, 2, 3, 4, 5);
zigzag_subarray(4, 4, 4);
zigzag_subarray(10, 20, 15, 12, 18);
zigzag_subarray(7, 7);
zigzag_subarray(6);
zigzag_subarray(3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5);

sub zigzag_subarray {
	
	my (@array, $p, $string, $test, $best, $k);
	
	# initialise
	@array = @_;
	say qq[\nInput:  (] . join(', ', @array) . ')';
	$test = '';
	$string = '';

	# make string of U = up, D = down, E = equal pairs
	for $p (0 .. $#array - 1) {
		$string .= $array[$p + 1] > $array[$p] ? 'U' :
			($array[$p + 1] < $array[$p] ? 'D' : 'E');
	}

	# check for largest [UD]*U, D[UD]*, [UD]*, [DU]*
	P: for ($p = int(@array / 2); $p >= 0; $p --) {
		for $k (1 .. 4) {
			if    ($k == 1) { $test = 'UD' x $p . 'U' }
			elsif ($k == 2) { $test = 'D' . 'UD' x $p }
			elsif ($k == 3) { $test = 'UD' x $p }
			elsif ($k == 4) { $test = 'DU' x $p }
			if ($string =~ m|$test|) {
				say qq[Output: ] . (length($test) + 1);
				return;
			}
		}
	}
}
