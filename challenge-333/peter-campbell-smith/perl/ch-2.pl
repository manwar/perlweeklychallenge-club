#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-08-04
use utf8;     # Week 333 - task 2 - Duplicate zeros
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

duplicate_zeros(1, 0, 2, 3, 0, 4, 5, 0);
duplicate_zeros(1, 2, 3);
duplicate_zeros(1, 2, 3, 0);
duplicate_zeros(0, 0, 1, 2);
duplicate_zeros(1, 2, 0, 3, 4);

sub duplicate_zeros {
	
	# map each 0 to 0, 0
	my @output = map($_ == 0 ? (0, 0) : $_, @_);
	
	# output as many elements in @output as in the input array
	say qq[\nInput:  (] . join(', ', @_) . ')';
	say qq[Output: (] . join(', ', @output[0 .. $#_]) . ')';
}
