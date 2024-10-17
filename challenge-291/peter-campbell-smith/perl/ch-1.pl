#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-10-14
use utf8;     # Week 291 - task 1 - Middle index
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

middle_index(2, 3, -1, 8, 4);
middle_index(0, 3, 4, -7);
middle_index(3, 4, -7, 0);
middle_index(1, 2, 3, 4, 5);
middle_index(9, 9, 9, 9, 9);

sub middle_index {
	
	my (@ints, $before, $after, $i);
	
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	
	# initialise
	$before = 0;
	$after += $_ for @ints;
	
	# loop over elements of @ints to find first MI
	for $i (0 .. scalar @ints - 1) {
		
		# remove $ints[$i] from $after
		$after -= $ints[$i];
		
		# do we have an MI?
		if ($before == $after) {
			say qq[Output: $i];
			return;
		}
		
		# add $ints[$i] to before, and try the next $i
		$before += $ints[$i];
	}
	
	# no MI found
	say qq[Output: -1];
}
