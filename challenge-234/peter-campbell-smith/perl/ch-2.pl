#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-09-11
use utf8;     # Week 234 task 2 - Unequal triplets
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($j, @ints);
unequal_triplets(4, 4, 4, 2, 3);
unequal_triplets(1, 1, 1, 1, 1);
unequal_triplets(4, 7, 1, 10, 7, 4, 1, 1);
unequal_triplets(-1, 0, 1);
unequal_triplets(5, 4, 3);

# bigger one
for $j (1 .. 9) {
	push @ints, int(rand(6));
}
unequal_triplets(@ints);

sub unequal_triplets {
	
	my (@ints, $n, $j, $int, @count, @unique, $item1, $item2, $item3, $combs, $i, $explain, $total, $u);
	
	# sanity check
	@ints = sort {$a <=> $b} @_;
	$n = scalar @ints;
	return unless $n >= 3;
	
	# get unique values and count of each value
	$j = -1;
	for $i (0 .. $n - 1) {
		$j ++ if ($i == 0 or $ints[$i] != $unique[$j]);
		$unique[$j] = $ints[$i];
		$count[$j] ++;
	}
	
	# get combinations
	$u = scalar @unique;
	$total = 0;
	$explain = '';
	for $item1 (0 .. $u - 3) {
		for $item3 (2 .. $u - 1) {
			for $item2 ($item1 + 1 .. $item3 - 1) {
				$combs = $count[$item1] * $count[$item2] * $count[$item3];
				$total += $combs;
				$explain .= qq[\n   triplet $unique[$item1], $unique[$item2], $unique[$item3] => ] .
					qq[$count[$item1] * $count[$item2] * $count[$item3] = $combs];
			}
		}
	}
	
	say qq[\nInput:  \@ints = (] . join(', ', @_) . ')';
	say qq[Output: $total$explain];
}