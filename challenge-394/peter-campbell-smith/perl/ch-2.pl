#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-10-05
use utf8;     # Week 394 - task 2 - Alternating vowels consonants
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

alternating_vowels_consonants('relocate', 'delocate', 'allocate');
alternating_vowels_consonants('apple', 'banana', 'cherry');
alternating_vowels_consonants('navigate', 'cavity', 'gravity');
alternating_vowels_consonants('pedalgia', 'pedalboard', 'pedantic');
alternating_vowels_consonants('schoolmaster', 'schoolhouse', 
	'schooling');
alternating_vowels_consonants('premium', 'uranium', 'tedium', 
	'triumph');
alternating_vowels_consonants('wäre', 'ärmel', 'klären', 'spärlich', 
	'verstärkt');
alternating_vowels_consonants('abekuvijo', 'ijoxxkuvxxabe', 
	'kuvabexijoxabe');

sub alternating_vowels_consonants {
	
	my (@words, $length, $size, $start, $substr, $z, $w, $longest, 
		$best);
	
	@words = @_;
	say qq[\nInput:  '] . join(q[', '], @words) . q['];
	
	@words = sort {length($a) <=> length($b)} @words;
	$longest = 0;
	$best = '';
	
	# get all the substrings of the shortest word
	$length = length($words[0]);
	SIZE: for ($size = $length; $size > 0; $size --) {
		last SIZE if $size < $longest;
		
		START: for $start (0 .. $length - $size) {
			$substr = substr($words[0], $start, $size);
			
			# must have alternating vowel/consonant
			$z = $substr;
			$z =~ s|[AEIOU]|0|gi;
			$z =~ s|[B-Y]|1|gi;
			next if ($z =~ m|00| or $z =~ m|11|);
			
			# does it occur in all the other words?
			for $w (1 .. $#words) {
				next START unless $words[$w] =~ m|$substr|;
			}
			
			# is it the longest (ie first)
			if ($size >= $longest) {
				$longest = $size;
				$best .= qq['$substr', ];
			}
		}
	}

	say qq[Output: ] . ($best ? substr($best, 0, -2) : '-none-');
}
