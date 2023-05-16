#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-15
use utf8;     # Week 217 task 2 - Max number
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

max_number(1, 23);
max_number(10, 3, 2);
max_number(31, 2, 4, 10);
max_number(5, 11, 4, 1, 2);
max_number(1, 10);
max_number(9900, 1, 99, 88);
max_number(47, 53, 99, 82, 9, 21, 36, 76, 77);

sub max_number {
	
	my (%left, $max);
	
	# put the numbers in a hash (as keys)
	$left{$_} = 1 for @_;

	# show result
	say qq[\nInput: (] . join(', ', @_) . ')';
	say qq[Output: ] . add_a_number(0, '', \%left);
}

sub add_a_number {
	
	my ($max, $so_far, $so_far2, %left, %more, $this);
	
	# initialise
	$max = $_[0];
	$so_far = $_[1];
	%left = %{$_[2]};
	
	# added all numbers
	unless (%left) {
		$max = $so_far if $so_far > $max;
	
	# add the next number
	} else {	
		for $this (keys %left) {
			%more = %left;
			delete $more{$this};			
			$max = add_a_number($max, $so_far . $this, \%more);
		}
	}
	
	# return the best so far
	return $max;
}
