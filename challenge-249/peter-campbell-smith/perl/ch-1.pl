#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-12-25
use utf8;     # Week 249 task 1 - Equal pairs
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

equal_pairs(1, 2, 3, 4, 1, 2, 3, 4);
equal_pairs(1, 2, 3, 4, 1, 2, 3);
equal_pairs(77, 23, 45, 12, 23, 99, 99, 12, 77, 45, 12, 12);

sub equal_pairs {
	
	my ($j, %seen, $result);
	%seen = ();
	
	# loop over supplied integers
	for $j (@_) {
		
		# seen one unpaired already, so this is an answer
		if ($seen{$j}) { 
			$result .= qq[($j, $j), ];
			delete $seen{$j};
			
		# note that we are looking for a mate
		} else {
			$seen{$j} = 1;
		}
	}
	
	# output answers: if success then %seen will be empty
	say qq[\nInput:  \@ints = (] . join(', ', @_) . ')';
	say qq[Output: ] . (scalar keys %seen ? 'not possible' : substr($result, 0, -2));
}
	