#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-11-13
use utf8;     # Week 243 task 1 - Reverse pairs
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

binmode(STDOUT, ':utf8');

reverse_pairs(1, 3, 2, 3, 1);
reverse_pairs(2, 4, 3, 5, 1);
reverse_pairs(1, 1, 1, 1, 1);

my (@nums, $i);
for $i (0 .. 10) {
	@nums[$i] = int(rand(200)) + 1;
}
reverse_pairs(@nums);

sub reverse_pairs {
	
	my (@nums, @nums2, $last, $i, $j, $k, $pairs, $explain);
	
	# initialise
	@nums = @_;
	$last = @nums - 1;
	$pairs = 0;
	$explain = '';
	@nums2 = map {$_ * 2} @nums;
	
	# loop over i and j
	for $i (0 .. $last - 1) {
		for $j ($i + 1 .. $last) {
			
			# test for condition
			if ($nums[$i] > $nums2[$j]) {
				$pairs ++;
				$explain .= qq[   \$nums[$i] = $nums[$i], \$nums[$j] = $nums[$j] ∵ $nums[$i] > $nums2[$j]] . qq[\n];
			}
		}
	}
	
	say qq[\nInput:  \@nums = (] . join(', ', @nums) . ')';
	say qq[Output: $pairs] . ($explain ? (qq[\n] . substr($explain, 0, -1)) : '');
}