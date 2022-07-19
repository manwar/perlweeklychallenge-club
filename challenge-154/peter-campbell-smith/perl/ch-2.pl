#!/usr/bin/perl

# Peter Campbell Smith - 2022-07-19
# PWC 174 task 2

use v5.28;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ':utf8');

# You are given a list of integers with no duplicates, e.g. [0, 1, 2].
# Write two functions, permutation2rank() which will take the list and determine its rank 
# (starting at 0) in the set of possible permutations arranged in lexicographic order, and 
# rank2permutation() which will take the list and a rank number and produce just that permutation.

# Blog: https://pjcs-pwc.blogspot.com/2022/07/disarium-disaster-and-rank-permutations.html

my (@tests, $test, $rank, $max, $perm);

# permutation must be some ordering of 0 .. $n - 1
@tests = ([1, 0, 2], [0, 2, 3, 1], [7, 3, 1, 0, 2, 6, 4, 5],
	[7, 14, 4, 11, 6, 0, 10, 1, 2, 3, 12, 5, 8, 13, 9],
	[1, 2, 4]);   # invalid
	
say qq[\nPerm to rank];	

for $test (@tests) {
	$rank = permutation2rank(@$test);
	say qq[perm: ] . join(', ', @$test) . qq[ => rank $rank];
}

say qq[\nRank to perm];

@tests = ([2, 2], [3, 3], [7, 37564], [14, 693492952393], [14, 0]);

for $test (@tests) {
	($max, $rank) = @$test;
	$perm = rank2permutation($max, $rank);
	say qq[terms: $max, rank: $rank => perm: $perm]; 
}
	

sub permutation2rank {
	
	my (@p, $n, @fac, @ranks, $i, $rank, $this_rank, $k, $j, $digit, @seen);
		
	# input permutation and count no of elements
	@p = @_;
	$n = scalar @p;
	
	# calculate factorials up to $n - 1 and initialise @ranks
	# see blog for definition of @ranks
	$fac[0] = 1;
	$ranks[0] = 0;
	for $i (1 .. $n) {
		$k = $p[$i - 1];
		$fac[$i] = $fac[$i - 1] * $i;
		$ranks[$i] = $i;
		
		# check valid perm with 1 occurrence of 0 .. $n - 1
		return 'invalid permutation' if ($k < 0 or $k >= $n or $seen[$k]);
		$seen[$k] = 1;
	}
	
	# loop over the components of the permutation and calculate how each contributes to the rank
	$rank = 0;
	for $i (0 .. $n - 1) {
		
		# $ranks[$digit] is the contribution to the ranking of this digit given that 
		# some digits have already been seen and can't be in this ranking position
		$digit = $p[$i];
		
		# so this digit is in $ranks[$digit] block and the block occupies [$n - 1 - $i]! rows
		$this_rank = $ranks[$digit];
		$rank += $this_rank * $fac[$n - 1 - $i];

		# now we mark this digit as having been seen, so can't occur in subsequent positions
		$ranks[$digit] = -1;
		
		# and re-jig @ranks ready for the next digit (see blog)
		$k = 0;
		for $j (0 .. $n - 1) {
			next if $ranks[$j] < 0;
			$ranks[$j] = $k;
			$k ++;
		}		
	}
	return $rank;
}

sub rank2permutation {
	
	my ($n, $rank, @fac, @ranks, @rranks, $k, $perm, $i, $j);
	
	($n, $rank) = @_;
	$n ++;
	
	# calculate factorials up to $n - 1 and initialise @ranks
	$fac[0] = 1;
	$ranks[0] = 0;
	for $i (1 .. $n - 1) {
		$fac[$i] = $fac[$i - 1] * $i;
		$ranks[$i] = $i;
	}
	
	# loop over the components of the permutation and calculate how each contributes to the rank
	$perm = '';
	for $i (0 .. $n - 1) {
		
		# calc $j = no of blocks, and subtract those from $rank
		$j = int($rank / $fac[$n - 1 - $i]);
		$rank -= $j * $fac[$n - 1 - $i];
		$perm .= qq[$ranks[$j], ];
		$ranks[$j] = -1;
		
		# and re-jig @ranks ready for the next digit
		$k = 0;
		for $j (0 .. $n - 1) {
			next if $ranks[$j] < 0;
			$ranks[$k] = $ranks[$j];
			$k ++;
		}	
	}
	return substr($perm, 0, -2);
}
