#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-17
# PWC 148 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# Write a script to generate all Eban Numbers <= 100.
# An Eban number is a number that has no letter ‘e’ in it when the number is spelled 
# in English (American or British)

my ($j, $words, @digits, @tenties, @teens);
@digits = ((''), qw[one two three four five six seven eight nine]);
@tenties = (('', ''), qw[twenty thirty forty fifty sixty seventy eighty ninety]);
@teens = qw[ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen];

# the easy bit
say qq[\nAll Eban Numbers <= 100];
for $j (1 .. 100) {
	$words = words($j);
	say qq[$j - $words] unless $words =~ m|e|;
}

# convert an integer to words (works up to 999,999)
sub words {
		
	my ($number, $thousands, $words);
	$number = $_[0];
	
	# deal with thousands
	$thousands = int($number / 1000);
	$words = $thousands != 0 ? words3($thousands) . ' thousand' : '';

	# and the rest
	$number -= $thousands * 1000;
	$words = $words . ' and' if ($thousands != 0 and $number < 100 and $number != 0); 
	$words = $words . words3($number);
	$words =~ s|.||; # remove initial blank
	return $words;
}

sub words3 {

	# convert 1-999 into words
	my ($number, $hundreds, $words3, $tens, $units, $hyphen);
	return 'zero' unless $number = $_[0];
	$words3 = '';
		
	# hundreds
	$hundreds = int($number / 100);
	$words3 = $words3 . ' ' . $digits[$hundreds] . ' hundred' if $hundreds != 0;
	$number -= $hundreds * 100;
	if ($number) {
		$words3 = $words3 . ' and' if $hundreds != 0;
		
		# tens and units
		$tens = int($number / 10);
		$units = $number - 10 * $tens;
		if ($tens != 1) {
			$hyphen = ($units != 0 and $tens != 0) ? '-' : '';
			$words3 = $words3 . ' ' . $tenties[$tens] . $hyphen . $digits[$units];
		} else {
			$words3 = $words3 . ' ' . $teens[$units];
		}
	}

	return $words3;
}
