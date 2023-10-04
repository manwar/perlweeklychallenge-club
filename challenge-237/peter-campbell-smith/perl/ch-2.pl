#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-02
use utf8;     # Week 237 task 2 - Maximise greatness
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use Algorithm::Loops 'NextPermuteNum';
use Time::HiRes ('gettimeofday', 'tv_interval'); 
binmode(STDOUT, ':utf8');

my ($j, $k, @nums);

say qq[Output1 uses the permutations method and Output2 uses the algorithm
described in my analysis.];

maximise_greatness(1, 3, 5, 2, 1, 3, 1);
maximise_greatness(1, 2, 3, 4);
maximise_greatness(9, 6, 3, 5, 1, 0, 8, 4, 14);
maximise_greatness(1, 2, 3, 1, 2, 3, 1, 2, 3);

sub maximise_greatness {
	
	my (@nums, @perms, $last, $greatness, $greatness_perm, $count, $j, $greatest, %seen, $distinct, $k,
		@sorted, @order, $n, $m, @best_perm, $t0, $elapsed);
	
	# FULL SEARCH OF PERMUTATIONS
	@nums = @_;
	$t0 = [gettimeofday];
	@perms = sort { $a <=> $b} @nums;
	$last = scalar @nums - 1;
	$greatness = 0;
	say qq[\nInput:   \@nums  = (] . join(', ', @nums) . ')';
	
	# loop over permutations
	do {
		
		# check list for greatness
		$count = 0;
		for $j (0 .. $last) {
			$count ++ if $nums[$j] < $perms[$j];
			last if $count + $last - $j <= $greatness;
		}
		
		# found a better one
		if ($count > $greatness) {
			$greatness = $count;
			$greatness_perm = join(', ', @perms);
		}
		$k ++;
		
	} while (NextPermuteNum(@perms) and $greatness != $last);
	
	$elapsed = int(tv_interval($t0) * 1000000);
	say qq[Output1: \@perms = ($greatness_perm)];
	say qq[      greatness = $greatness ($k permutations, time ${elapsed}μs)];
	
	# PETER'S IMPROVED METHOD
	$t0 = [gettimeofday];
	@sorted = sort { $a <=> $b} @nums;
	@perms = @sorted;
	$greatness = 0;
	
	# loop over left shifts
	K: for $k (0 .. $last - 1) {
		push(@perms, shift @perms);
		$count = 0;
		for $j (0 .. $last) {
			$count ++ if $sorted[$j] < $perms[$j];
			if ($count > $greatness) {
				$greatness = $count;
				@best_perm = @perms;
			}
			last K if $greatness == $last;
		}		
	}
	
	# unsort @best_perm into the same order as @nums
	for $j (0 .. $last) {
		$n = $nums[$j];
		for $k (0 .. $last) {
			if ($sorted[$k] == $n) {
				$m = $k;
				$sorted[$k] = 99999;
				last;
			}
		}
		$order[$j] = $best_perm[$m];
	}
	
	$elapsed = int(tv_interval($t0) * 1000000);
	say qq[Output2: \@perms = (] . join(', ', @order) . qq[)];
	say qq[      greatness = $greatness (time ${elapsed}μs)];
}
