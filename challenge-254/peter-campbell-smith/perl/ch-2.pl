#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-01-29
use utf8;     # Week 254 task 2 - Reverse vowels
use strict;   # Peter Campbell Smith
use warnings; 
binmode STDOUT, ':utf8';

reverse_vowels('triumvirate');
reverse_vowels('bcdf');
reverse_vowels('bcdfa');
reverse_vowels('abcdf');
reverse_vowels('aeiou');
reverse_vowels('aeiiou');
reverse_vowels('supercalifragilisticexpialidocious');

sub reverse_vowels {
	
	my ($s, $p1, $p2, $x, @letters);
	
	# initialise
	$s = lc(shift);	
	@letters = split('', $s);
	$p1 = 0;
	$p2 = scalar(@letters) - 1;
	
	# loop while left pointer left of right pointer
	LOOP: while ($p1 < $p2) {
		
		# if left pointer has found a vowel
		if ($letters[$p1] =~ m|[aeiou]|) {
			
			# wind back right pointer until it meets a vowel or left pointer
			while ($p1 < $p2) {
				
				# right pointer has found a vowel, so switch left and right
				if ($letters[$p2] =~ m|[aeiou]|) {
					$x = $letters[$p2];
					$letters[$p2 --] = $letters[$p1];
					$letters[$p1 ++] = $x;
					next LOOP;
				
				# not a vowel, move right pointer to the left
				} else {
					$p2 --;
				}
			}
			
		# not a vowel, so move left pointer to the right	
		} else {
			$p1 ++;
		}
	}	
	say qq[\nInput:  \$s = '$s'\nOutput:      '] . join('', @letters), qq['];	
}