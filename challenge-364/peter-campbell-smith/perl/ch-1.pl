#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-03-09
use utf8;     # Week 364 - task 1 - Decrypt string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

decrypt_string('10#11#12');
decrypt_string('1326#');
decrypt_string('25#24#123');
decrypt_string('20#5');
decrypt_string('1910#26#');

sub decrypt_string {
	
	my ($string, $base);
	
	# initialise
	$string = $_[0];
	say qq[\nInput:  '$string'];
	$base = ord('a') - 1;
	
	# apply rules
	$string =~ s|([12][0-9])#|chr($base + $1)|ge;
	$string =~ s|([1-9])|chr($base + $1)|ge;
	
	say qq[Output: '$string'];
}
