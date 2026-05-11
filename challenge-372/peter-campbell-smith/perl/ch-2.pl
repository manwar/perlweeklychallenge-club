#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-05-04
use utf8;     # Week 372 - task 2 - Largest substring
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

largest_substring('algebra');
largest_substring('parliament');
largest_substring('subdermatoglyphic');
largest_substring('panorama');
largest_substring('summer');
largest_substring('supercalifragilisticexpialidocious');

sub largest_substring {
	
	my (@string, @longest, $j, $k);
	
	# initialise
	@string = split('', $_[0]);
	@longest = (-1, '', '');
	
	# loop over possible starting and ending characters
	for $j (0 .. $#string - 1) {
		for $k ($j + 1 .. $#string) {
			
			# found a matching pair
			if ($string[$j] eq $string[$k]) {
				if ($k - $j - 1 > $longest[0]) {
					@longest = ($k - $j - 1, join('', @string[$j + 1 .. $k - 1]), $string[$j]);
				}
			}
		}
	}
					
	say qq[\nInput:  '] . join('', @string) . q['];
	say qq[Output: ] . ($longest[0] >= 0 ? qq[$longest[0] ('$longest[1]' bracketed by '$longest[2]')] : '-1');
}
