#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-10-13
use utf8;     # Week 343 - task 1 - Zero friend
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

zero_friend(4, 2, -1, 3, -2);
zero_friend(-5, 5, -3, 3, -1, 1);
zero_friend(7, -3, 0, 2, -8);
zero_friend(71.6, -93.4, 102.102, -1000, 41.2, -70.9, 999, 4e6, -1e-3);

# bigger example
my @ints;
push @ints, (int(rand(1e6) - 5e5)) / 1e3 for 0 .. 49;
zero_friend(@ints);

sub zero_friend {
	
	# sort by absolute values
	my @x = sort {abs($a) <=> abs($b)} @_;
	
	say qq[\nInput:  ] . join(', ', @_);
	say qq[Output: ] . abs($x[0]);
}
