#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-05-25
use utf8;     # Week 375 - task 1 - Single common word
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

single_common_word
	(['apple', 'banana', 'cherry'], ['banana', 'cherry', 'date']);
single_common_word
	(['apple', 'banana', 'cherry'], ['date', 'orange', 'plum']);
single_common_word
	(['apple', 'apple', 'cherry', 'cherry'], ['apple', 'cherry']);
single_common_word
	(['APPLE', 'BANANA', 'cherry'], ['banana', 'cherry', 'apple']);
single_common_word
	(['a' .. 'z'], ['b' .. 'y']);
	
sub single_common_word {
	
	my ($array, $word, $results, @results, %occurs);
	
	# count frequency of words in each array
	for $array (0 .. 1) {
		for $word (@{$_[$array]}) {
			
			# add 1 if in array1 or 1_000_000 if in array2
			$occurs{$word} += $array ? 1e6 : 1; 
		}
	}
	
	# words occuring once in each array have occurs == 1000001
	@results = grep {$occurs{$_} == 1e6 + 1} keys %occurs;
	
	# report
	say qq[\nInput:  \@array1 = ('] . join(q[', '], @{$_[0]}) . q[')];
	say qq[        \@array2 = ('] . join(q[', '], @{$_[1]}) . q[')];
	print qq[Output: ] . scalar @results;
	print q[ - ('] . join(q[', '], @results) . q[')] 
		if scalar @results;
	say '';
}
