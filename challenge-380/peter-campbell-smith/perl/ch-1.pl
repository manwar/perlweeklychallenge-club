#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-29
use utf8;     # Week 380 - task 1 - Sum of frequencies
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

sum_of_frequencies('abcde');
sum_of_frequencies('');
sum_of_frequencies('banana');
sum_of_frequencies('rhythm');
sum_of_frequencies('aeiouuu');
sum_of_frequencies(
	'Writeascripttofindthevowelandconsonantwithmaximumfrequency' .
	'Returnthesumoftwofrequencies');
	
sub sum_of_frequencies {
	
	my ($string, $j, $k, @freq, $max_v, $max_c);
	
	# initialise
	$string = shift;
	say qq[\nInput:  '$string'];
	$string = lc($string);
	$string =~ s|[^a-z]||g;
	$freq[$_] = 0 for (ord('a') .. ord('z') + 4);
	$max_v = $max_c = '~';
	
	# count frequencies of each letter in $string
	for $j (0 .. length($string) - 1) {
		$freq[ord(substr($string, $j, 1))] ++;
	}
	
	# find maximum frequencies
	for $k ('a', 'e', 'i', 'o', 'u') {
		$max_v = $k if $freq[ord($k)] > $freq[ord($max_v)];
	}
	for $k ('b' .. 'd', 'f' .. 'h', 'j' .. 'n', 'p' .. 't', 
		'v' .. 'z') {  
		$max_c = $k if $freq[ord($k)] > $freq[ord($max_c)];
	}
	
	# report
	say qq[Output: ] . ($freq[ord($max_v)] + $freq[ord($max_c)]) . 
		qq[ : vowel '$max_v' = $freq[ord($max_v)], ] .
		qq[consonant '$max_c' = $freq[ord($max_c)]];
}
