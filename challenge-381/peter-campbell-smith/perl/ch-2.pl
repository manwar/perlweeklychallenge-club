#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/381/2

use v5.26;    # The Weekly Challenge - 2026-07-06
use utf8;     # Week 381 - task 2 - Smaller greater element
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

smaller_greater_element(1, 1, 1, 1);
smaller_greater_element(4, 8, 12, 12, 1, 1);
smaller_greater_element(9, 6, 6, 3);
smaller_greater_element(0, -5, 10, -2, 4);

my @x;
push @x, int(rand(10)) + 1 for 1 .. 50;
smaller_greater_element(@x);

sub smaller_greater_element {
	
	my (@array, @explain, $n);
	
	# initialise
	say qq[\nInput:  ] . join(', ', @_);
	@array = sort {$a <=> $b} @_;
	
	# look for candidates
	for $n (0 .. $#array) {
		push @explain, $array[$n] if ($array[$n] > $array[0] and 
			$array[$n] < $array[-1]);
	}
	
	# report
	say qq[Output: ]  . (@explain ? (scalar @explain . 
		qq[ (] . join(', ', @explain) . ')') : 'none');
}

