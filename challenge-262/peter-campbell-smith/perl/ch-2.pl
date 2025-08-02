#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-03-25
use utf8;     # Week 262 - task 2 - Count equal divisible
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my (@ints, $j);

count_equal_divisible([3, 1, 2, 2, 2, 1, 3], 2);
count_equal_divisible([1, 2, 3], 1);

# bigger example
for $j (0 .. 99) {
	push @ints, int(rand(50) + 1);
}
count_equal_divisible(\@ints, 23);

sub count_equal_divisible {
	
	my (@ints, $i, $j, $ij, $k, $count, $explain);
	
	# initialise
	@ints = @{$_[0]};
	$k = $_[1];
	$count = 0;
	$explain = '';
	
	# loop over all pairs where $j > $i
	for $i (0 .. @ints - 2) {
		for $j ($i + 1 .. @ints - 1) {
			
			# discard unless values are equal
			next unless $ints[$i] == $ints[$j];
			
			# discard unless $i * $j is a multiple of $k
			$ij = $i * $j;
			next unless $ij / $k == int($ij / $k);
			
			# found an answer
			$count ++;
			$explain .= qq[$i * $j = $ij, ];
		}
	}
	
	# show results	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) .
		qq[), \$k = $k];
	$explain =~ s|(.*)..$|($1)|;
	say qq[Output: $count $explain];
}
