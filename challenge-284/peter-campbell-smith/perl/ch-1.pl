#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-08-26
use utf8;     # Week 284 - task 1 - Lucky integer
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

lucky_integer(2, 2, 3, 4);
lucky_integer(1, 2, 2, 3, 3, 3);
lucky_integer(1, 1, 1, 3);
lucky_integer(3, 3, 3, 20, 20, 20, 20, 20, 20, 20, 20, 20,
	20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20);
lucky_integer(-1, -2, 0, 1, 1, 2, 2, 2, 3, 3, 3);
lucky_integer(-2, -2, -3, -3, -3);

my @ints;
for (1 .. 50) {
	push @ints, int(rand(20)) + 1;
}
lucky_integer(@ints);

sub lucky_integer {
	
	my (@ints, %freq, $j, $e, $big);
	
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	
	# calculate frequencies
	$big = 1e6;
	$freq{$_ + $big} ++ for @ints;
	
	# find the largest lucky one
	for $e (reverse sort keys %freq) {
		if ($e - $big == $freq{$e}) {
			say qq[Output: ] . ($e - $big);
			return;
		}
	}
	
	# or they are all unlucky
	say qq[Output: -1];
}
