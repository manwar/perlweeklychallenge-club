#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2024-01-15
use utf8;     # Week 252 task 1 - Special numbers
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge
binmode STDOUT, ':utf8';

my ($j, @ints);

special_numbers(1, 2, 3, 4);
special_numbers(2, 7, 1, 19, 18, 3);
special_numbers(7, 7, 7, 7, 11);

for $j (0 .. 31) {
	push @ints, int(rand(20) + 1);
}
special_numbers(@ints);

sub special_numbers {
	
	my (@ints, $j, $squares, @specials, $last);
	
	# initialise
	@ints = @_;
	$last = @ints - 1;
	
	# check each member
	for $j (0 .. $last) {
		if (($last + 1) / ($j + 1) == int(($last + 1) / ($j + 1))) {
			$squares += $ints[$j] ** 2;
			push @specials, $j + 1;
		}
	}
	
	# show results
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: $squares ∵ \@specials: ] . join(', ', @specials);
}
