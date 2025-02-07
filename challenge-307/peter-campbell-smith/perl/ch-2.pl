#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-02-03
use utf8;     # Week 307 - task 2 - Find anagrams
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

find_anagrams('acca', 'dog', 'god', 'perl', 'repl');
find_anagrams('abba', 'baba', 'aabb', 'ab', 'ab');
find_anagrams(qw[abcd abdc acbd acdb adbc adcb bacd badc 
	bcad bcda mouse bdac bdca cabd cadb cbad cbda cdab 
	cdba dabc dacb dbac dbca dcab dcba]); 

sub find_anagrams {
	
	my (@words, $point);
	
	@words = @_;
	say qq[\nInput:  \@words = ('] . join(q[', '], @words) . q[')];
	
	# sort each word alphabetically
	$words[$_] = join('', sort(split('', $words[$_]))) for 0 .. $#words;
	
	# walk along the array
	$point = 0;
	while (1) {
		
		# finished
		last if $point == $#words;
		
		# word followed by anagram
		if ($words[$point] eq $words[$point + 1]) {
			
			# .. followed by no more words
			if ($point + 2 > $#words) {
				@words = @words[0 .. $point];
				
			# .. followed by more words
			} else {
				@words = (@words[0 .. $point], @words[$point + 2 .. $#words]);
			}
		
		# word not followed by anagram
		} else {
			$point ++;
		}
	}	
	say qq[Output: ] . scalar(@words);
}
