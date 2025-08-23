#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-08-18
use utf8;     # Week 335 - task 1 - Common characters
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

common_characters('bella', 'label', 'roller');
common_characters('cool', 'lock', 'cook');
common_characters('hello', 'world', 'pole');
common_characters('abc', 'def', 'ghi');
common_characters('aab', 'aac', 'aaa');

sub common_characters {
	
	my (@words, @chars, $count, $c, $min, $output, $w, $k);
	
	no warnings 'uninitialized';
	@words = @_;
    
	# create count of character $c in word $w
	for $w (0 .. $#words) {
		@chars = split('', $words[$w]);
		$count->{$chars[$_]}->[$w] ++ for 0 .. $#chars;
	}
	
	# loop $c over characters
	for $c (sort keys %$count) {
		
		# find minimum number of occurrences of $c in all words  
		$min = 1e6;
		for $w (0 .. $#words) {
			$k = $count->{$c}->[$w];
			$min = $k if $k < $min;
		}
		
		# output that number of occurrences of $c
		$output .= qq['$c', ] for 1 .. $min;
	}
	
	# report
	say qq[\nInput:  ('] . join(q[', '], @words) . q[')];
	say qq[Output: (] . substr($output, 0, -2) . ')';
}
