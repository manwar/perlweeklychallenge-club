#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/388/2

use v5.26;    # The Weekly Challenge - 2026-08-24
use utf8;     # Week 388 - task 2 - Secret Santa
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Algorithm::Combinatorics ('permutations');

secret_santa(2);
secret_santa(3);
secret_santa(4);
secret_santa(5);

sub secret_santa {
	
	my ($people, $result, @names, $iter, $p, @gifts, @sequences);
	
	# initialise
	$people = shift;
	
	# the answer
	$result = 1;
	$result *= $_ for 2 .. $people - 1;
	
	# explanation
	@names = (2 .. $people);
	$iter = permutations(\@names);
	while ($p = $iter->next) {
		@gifts = @$p;
		unshift @gifts, 1;
		push @gifts, 1;
		push @sequences, join(' → ', @gifts);
	}
	
	# report
	say qq[\nInput:  $people];
	say qq[Output: $result];
	say $_ for @sequences;
}
