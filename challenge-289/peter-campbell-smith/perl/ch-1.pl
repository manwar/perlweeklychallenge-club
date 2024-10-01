#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-30
use utf8;     # Week 289 - task 1 - Third maximum
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

third_maximum(1, 2, 3, 4, 4, 5);
third_maximum(1, 2);
third_maximum(5);
third_maximum(7, 7, 7, 7, 7);

# make longer example
my @ints;
push @ints, int(rand(100)) 
for 0 .. 49;
third_maximum(@ints);

sub third_maximum {
	
	my (@ints, @max, $j);
	
	say qq[\nInput:  \@ints = (] . join(', ', @_) . ')';

	# reverse sort @ints
	@ints = reverse sort {$a <=> $b} @_;
	
	# use the stated rules to find the first three distinct numbers
	for $j (@ints) {
		if (not $max[1]) {
			$max[1] = $j;
		} elsif (not $max[2] and $j != $max[1]) {
			$max[2] = $j;
		} elsif (not $max[3] and $max[2] and $j != $max[2]) {
			$max[3] = $j;
			last;
		}
	}
	
	# output
	if ($max[3]) {
		say qq[Output: \$max1 = $max[1], \$max2 = $max[2], \$max3 = $max[3]];
	} else {
		say qq[Output: \$max = ] . ($max[2] ? ($max[2] > $max[1] ? $max[2] : $max[1]) : $max[1]);
	}
}
