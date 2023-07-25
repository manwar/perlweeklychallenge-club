#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-24
use utf8;     # Week 227 task 2 - Roman maths
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

roman_maths('IV + V');
roman_maths('M - I');
roman_maths('X / II');
roman_maths('XI * VI');
roman_maths('VII ** III');
roman_maths('V - V');
roman_maths('V / II');
roman_maths('V - X');
roman_maths('LXXX * L');
roman_maths('XLIII * XCIII');

sub roman_maths {
	
	my ($first, $op, $second, $result);
	say qq[\nInput:  $_[0]];
	
	# split input string into operands and operator
	if ($_[0] =~ m|^\s*([IVXLCDM]+)\s*(\S{1,2})\s*([IVXLCDM]+)\s*$|) {
		($first, $op, $second) = ($1, $2, $3);
		
		# if the operator is valid, evaluate the operation
		if ($op =~ m!^-|\+|\*|/|\*\*$!) {
			$result = encode_roman(eval(decode_roman($first) .  $op  . decode_roman($second)));
			say qq[Output: $result];
		}
	}
	say qq[invalid input] unless defined $result;
}

sub decode_roman {
	
	# convert roman to arabic
	my (@bits, $roman, $arabic, $n);
	
	# roman fragments and equivalents
	@bits = ('IV', 4, 'IX', 9, 'XL', 40, 'XC', 90, 'CD', 400, 'CM', 900,
		'I', 1, 'V', 5, 'X', 10, 'L', 50, 'C', 100, 'D', 500, 'M', 1000);
	
	# successively delete bits from $roman and add them to $arabic
	$roman = $_[0];
	$arabic = 0;
	for ($n = 0; $n < @bits; $n += 2) {
		$arabic += $bits[$n + 1] * $roman =~ s|$bits[$n]||g;
	}
	return $arabic;
}

sub encode_roman {
	
	# convert arabic to roman
	my (@bits, $n, $arabic, $roman);
	
	# roman fragments and equivalents
	@bits = ('M', 1000, 'CM', 900, 'D', 500, 'CD', 400, 'C', 100, 'XC', 90,
		'L', 50, 'XL', 40, 'X', 10, 'IX', 9, 'V', 5, 'IV', 4, 'I', 1);
		
	# special cases
	$arabic = $_[0];
	return 'nulla' if $arabic == 0;
	return 'non potest' if ($arabic < 0 or $arabic > 3999 or $arabic != int($arabic));
	
	# successively subtract bits from $arabic and add them to $roman
	$roman = '';
	for ($n = 0; $n < @bits; $n += 2) {
		if ($arabic >= $bits[$n + 1]) {
			
			# may have to repeat some roman symbols - eg XXX
			while ($arabic >= $bits[$n + 1]) {
				$roman .= $bits[$n];
				$arabic -= $bits[$n + 1];
			}
		}					
	}
	return $roman;
}
