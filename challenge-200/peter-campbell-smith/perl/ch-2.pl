#!/usr/bin/perl

# Peter Campbell Smith - 2023-01-16
# PWC 200 task 2

use v5.28;
use utf8;
use warnings;

# Task: Write a program that accepts any positive integer and draws that number as a horizontal sequence of
# ASCII seven segment displays.

# Blog: 

my (@tests, @truth, $test, @digit, @display, $offset, $points, $row, $column, $segments, $segment);

@truth = qw[abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg];

@tests = (200, 31415926535, 9876543210);

# each digit is 7 lines high and 7 characters wide
# each digit starts 9 characters further right than the previous one

# create digits => character . row . column
$digit[ord('a')] = '-00 -01 -02 -03 -04 -05 -06';
$digit[ord('b')] = '|16 |26';
$digit[ord('c')] = '|46 |56';
$digit[ord('d')] = '-60 -61 -62 -63 -64 -65 -66';
$digit[ord('e')] = '|40 |50';
$digit[ord('f')] = '|10 |20';
$digit[ord('g')] = '-30 -31 -32 -33 -34 -35 -36';

# loop over tests
for $test (@tests) {
	@display = ();
	$offset = 0;
	
	# blank display
	for $row (0 .. 6) {
		for $column (0 .. length($test) * 9) {
			$display[$row][$column] = ' ';
		}
	}
	
	# loop over digits in $test and blank area of display
	while ($test =~ m|(.)|g) {   # digit
		
		# loop over segments for this digit
		$segments = $truth[$1];
		
		# draw these segments in $display
		while ($segments =~ m|(.)|g) {
			$points = $digit[ord($1)];
			while ($points =~ m|(.)(\d)(\d)|g) {
				$display[$2][$3 + $offset] = $1;
			}
		}
		
		# move right 9 characters width (7 for digit plus 2 blank)
		$offset += 9;
	}
	
	# show the display
	for $row (0 .. 6) {
		for $column (0 .. $offset - 2) {
			print $display[$row][$column];
		}
		say '';
	}
}	

