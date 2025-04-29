#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-04-28
use utf8;     # Week 319 - task 2 - Minimum common
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

minimum_common([1, 2, 3, 4], [3, 4, 5, 6]);
minimum_common([1, 2, 3, 4], [5, 6, 7, 8]);
minimum_common([1, 2, 3, 4], [3, 4, 5, 6]);
minimum_common([-1, -2, -3, 0, 1], [-7, 1, 7]);

my (@array1, @array2);
push @array1, int(rand(500) + 1) for 0 .. 99;
push @array2, int(rand(500) + 1) for 0 .. 99;
minimum_common(\@array1, \@array2);

sub minimum_common {
	
	my (@array1, @array2, %exists, $i);
	
	# initialise
	@array1 = @{$_[0]};
	@array2 = @{$_[1]};
	say qq[\nInput:  \@array1 = (] . join(', ', @array1) . '),';	
	say qq[        \@array2 = (] . join(', ', @array2) . ')';	
	
	# sort @array1 and record what $exists in @array2
	@array1 = sort {$a <=> $b} @array1;
	$exists{$_} = 1 for @array2;
	
	# look for the smallest number in both arrays
	for $i (@array1) {
		if ($exists{$i}) {
			say qq[Output: $i];
			return;
		}
	}
	say qq[Output: -1];
}
