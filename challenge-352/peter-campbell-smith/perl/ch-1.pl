#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-15
use utf8;     # Week 352 - task 1 - Match string
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

match_string('cat', 'cats', 'dog', 'dogcat', 'dogcat', 'rat', 'ratcatdogcat');
match_string('hello', 'hell', 'world', 'wor', 'ellow', 'elloworld');
match_string('cat', 'dog', 'mouse', 'elephant', 'giraffe', 'alligator');
match_string('cat', 'cat', 'cat', 'cat', 'cat', 'cat');
match_string(qw[Write a script to return all strings that 
	are a substring of another word in the given array 
	in the order they occur]);

sub match_string {
	
	my (@words, $n, $output, %seen, @length, $i, $j);
	
	# initialise
	@words = @_;
	$n = @words - 1;
	$output = '';
	
	# record lengths
	push(@length, length($_)) for @words;
	
	# loop over source words and discard any seen already
	WORD: for $i (0 .. $n) {
		next if $seen{$words[$i]};
		$seen{$words[$i]} = 1;
		
		# loop over target words
		for $j (0 .. $n) {
			
			# discard unless source is subset of target 
			next if ($length[$j] <= $length[$i] or $words[$j] !~ m|$words[$i]|);
			
			# record, and skip to next source word
			$output .= qq['$words[$i]', ];
			next WORD;
		}
	}
	
	say qq[\nInput:  '] . join(qq[', '], @words) . q['];
	say qq[Output: ] . ($output ? substr($output, 0, -2) : 'none');
}
