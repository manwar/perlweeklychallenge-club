#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-15
use utf8;     # Week 265 - task 1 - 33% appearance
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my ($j, @ints);

over_33perct_appearance(1, 2, 3, 3, 3, 3, 4, 2);
over_33perct_appearance(1, 1);
over_33perct_appearance(1, 2, 3);
over_33perct_appearance(1, 2, 3, 4);
over_33perct_appearance(8, 8, 8, 9, 9, 9, 7, 7, 7);

for $j (1 .. 100) {
	push @ints, int(rand(3)) + 1;
}
over_33perct_appearance(@ints);

sub over_33perct_appearance {
	
	my (@ints, @times, $one_third, $i);
	
	# intialise
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	$one_third = (scalar @ints) * 0.33;
	
	# count frequenceies
	$times[$_] ++ for @ints;
	
	# find smallest with >33%
	for ($i = 0; $i < @times; $i ++) {
		next unless defined $times[$i];
		if ($times[$i] > $one_third) {
			say qq[Output: $i (] . int($times[$i] / @ints * 100) . '%)';
			return;
		}
	}
	
	# none found
	say qq[Output: undef];
}
