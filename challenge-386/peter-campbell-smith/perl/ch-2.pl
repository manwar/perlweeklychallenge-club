#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/386/2

use v5.26;    # The Weekly Challenge - 2026-08-10
use utf8;     # Week 386 - task 2 - Rational numbers
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

rational_numbers('0.(12)', '0.(121)');
rational_numbers('0.12(32)', '0.1(23)');
rational_numbers('0.1(234)', '0.12(342)');
rational_numbers('12.99(99)', '13');
rational_numbers('0.(123)', '.1(231)');

rational_numbers('0.000', '0');
rational_numbers('42', '41.9999999(9)');
rational_numbers('0.456(456)', '0.45645(645)');

sub rational_numbers {
	
	my (@r, $j, $num, $brac, $unbrac, $len, $half, $k, $mult, 
		$substr, $last);
	
	# initialise
	@r = @_;
	say qq[\nInput:  \$rat1 = $r[0], \$rat2 = $r[1]];
	
	# canonicalise the numbers (see blog)
	for $j (0, 1) {
		$num = $r[$j];
		
		# split into bracketed and unbracketed parts
		if ($num =~ m|(.*) \( (.*) \)|x) {
			($unbrac, $brac) = ($1, $2);
			
			# shorten the bracketed part if possible
			$len = length($brac);
			$half = int($len / 2);
			$mult = 1;
			for $k (1 .. $half) {
				$mult = $len / $k;
				if ($mult == int($mult)) {
					$substr = substr($brac, 0, $k);
					if ($brac eq $substr x $mult) {
						$brac = $substr;
						last;
					}
				}
			}
			
			# shorten the unbracketed part if possible
			while ($unbrac =~ m|^(.*)$brac$|g) {
				$unbrac = $1;
			}
			while (1) {
				$last = substr($unbrac, -1);
				last unless $last =~ m|\d|;
				if ($brac =~ m|^(.*)$last(.*)$|) {
					$brac = $last . $2 . $1;
					$unbrac = substr($unbrac, 0, -1);
				} else {
					last;
				}
			}		
			
			# if the bracketed part is (9) add 1 to the digit before
			if ($brac eq '9') {
				$unbrac =~ m|.*\.(\d*)|;
				$mult = 10 ** (length($1));
				$unbrac = (qq[$unbrac] * $mult + 1) / $mult;
				$brac = '';
			}
			
			# if the bracketed part is (0), delete it
			$num = $unbrac . ($brac ? qq[($brac)] : '');
		}
		
		# if the number ends with '.' and any zeroes, delete them
		$num = $1 if $num =~ m|^(\d*)\.0*$|;
		
		# if the number starts with '.', precede it with '0'
		$num = qq[0$num] if $num =~ m|^\.|;
		
		$r[$j] = $num;		
	}
	
	say qq[Output: ] . ($r[0] eq $r[1] ? qq[true - both are $r[0]] : 
		qq[false - $r[0] and $r[1]]);
}
