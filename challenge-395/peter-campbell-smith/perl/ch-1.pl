#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-10-12
use utf8;     # Week 395 - task 1 - Complex number
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

complex_number('1 + 1i', '1 + 1i');
complex_number('1+(-1)i', '1+(-1)i');
complex_number('0+3i', '0+4i');
complex_number('3+4i', '3+(-4)i');
complex_number('50+(-20)i', '-10+30i');
complex_number('0.1 + 0.2i', '0.3 - 0.4i');

sub complex_number {
	
	my ($aa, $bb, $cc, $dd, $prod);
		
	# extract the 4 coefficients
	($aa, $bb) = $_[0] =~ m|(-?[\d\.]+).*?(-?[\d\.]+)|;
	($cc, $dd) = $_[1] =~ m|(-?[\d\.]+).*?(-?[\d\.]+)|;
	
	# calculate the product
	$prod = ($aa * $cc - $bb * $dd) . ' + ' .
		    ($aa * $dd + $bb * $cc) . 'i';
	
	say qq[\nInput:  ($_[0]) × ($_[1])];
	say qq[Output: $prod];
}
