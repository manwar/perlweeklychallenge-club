#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-31
use utf8;     # Week 228 task 2 - Empty array
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($j, @int);

empty_array(3, 4, 2);
empty_array(1, 2, 3);
empty_array(1);
empty_array();
empty_array(8, 3, 4, 7, 6, 2, 9, 1);

sub empty_array {
	
	my (@array, $smallest, $operations, $explain);
	
	@array = @_;
	$operations = 0;
	$explain = '';
	while (1) {
		
		# if it's empty we're done
		unless (@array) {
			say qq[\nInput:  \@int = (] . join (', ', @_) . ')';
			say qq[Output: $operations$explain];
			return;
		}
		
		# if the first element is the smallest then remove it
		$operations ++;		
		$smallest = $array[0];
		$smallest = $_ < $smallest ? $_ : $smallest for @array;
		
		if ($array[0] == $smallest) {
			shift @array;	
			$explain .= qq[\n   Operation $operations: remove element $smallest:          (] . join(', ', @array) . ')';

		# otherwise move it to the end
		} else {
			push(@array, shift @array);
			$explain .= qq[\n   Operation $operations: move element $array[-1] to the end: (] . join(', ', @array) . ')';
		}
	}
}
