#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-23
use utf8;     # Week 327 - task 2 - Mad
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

mad(4, 1, 2, 3);
mad(1, 3, 7, 11, 15);
mad(1, 5, 3, 8);

# bigger example
my (@input);
push @input, int(rand(10000)) for 0 .. 74;
mad(@input);

sub mad {
	
	my(@input, $i, $j, %difference, @sorted);
	
	# initialise (and sort to match Mohammad's output)
	@input = sort @_;
	
	# create all pairs
	for $i (0 .. $#input - 1) {
		for $j ($i + 1 .. $#input) {
			
			# store the differences in $difference{$diff}
			$difference{abs($input[$i] - $input[$j])} .= qq[[$input[$i], $input[$j]], ];
		}
	}
	
	# sort the keys of @difference - so $sorted[0] is the least
	@sorted = sort {$a <=> $b} keys %difference;
		
	# report
	say qq[\nInput:  (] . join(', ', @_) . q[)];
	say qq[Output: ] . substr($difference{$sorted[0]}, 0, -2);
}
