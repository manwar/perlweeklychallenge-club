#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-02-24
use utf8;     # Week 310 - task 2 - Sort odd even
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

sort_odd_even(4, 1, 2, 3);
sort_odd_even(3, 1);
sort_odd_even(5, 3, 2, 1, 4);
sort_odd_even(3, 7, 9, 3, 2, 6, 8, 1, 0, 4, 2, 5);
sort_odd_even(-3, -2, -1, 0, 1, 2, 3);

sub sort_odd_even {
	
	my (@array, $v, @odds, @evens, @output);
	
	# separate odds and evens
	@array = @_;
	for $v (0 .. $#array) {
		unshift @odds, $array[$v] if $v & 1;
		unshift @evens, $array[$v] unless $v & 1;
	}
	
	# sort them as specified
	@odds = sort {$b <=> $a} @odds;
	@evens = sort {$a <=> $b} @evens;

	# recreate @array in sorted order
	for $v (0 .. $#array) {
		push @output, shift @odds if $v & 1;
		push @output, shift @evens unless $v & 1;
	}
	
	say qq[\nInput:  \@array = (] . join(', ', @array) . ')';
	say qq[Output:        = (] . join(', ', @output) . ')';
}
