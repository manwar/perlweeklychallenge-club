#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-11-13
use utf8;     # Week 243 task 2 - Floor sum
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

floor_sum(2, 5, 9);
floor_sum(7, 7, 7);

# more interesting one
my @nums;
$nums[$_] = int(rand(100)) + 1 for 0 .. 10;
floor_sum(@nums);

sub floor_sum {
	
	my (@nums, $m, $n, $sum, $floor, $explain);
	
	# initialise  and sort input
	$sum = $floor = 0;
	$explain = '';
	@nums = sort {$a <=> $b} @_;
	
	# loop over m and n
	for $m (@nums) {
		for $n (@nums) {
			
			# skip the rest of the (sorted) $n's because $floor will be 0
			last if $m < $n;
			
			# floor will be 1 if $m less than twice $n
			if ($m < $n * 2) {
				$floor = 1;
				
			# otherwsie do the division
			} else {
				$floor = int($m / $n);
			}
			
			$sum += $floor;
			$explain .= qq[floor($m / $n) = $floor~];
		}
	}
	
	# reformat and display
	$explain =~ s/(.*?)~(.*?)~/sprintf(qq[   %-21s |  %-21s\n], $1, $2)/egm;
	$explain =~ s|\nf|\n   f|;
	
	say qq[\nInput:  \@nums = (] . join(', ', @_) . ')';
	say qq[Output: $sum\n] . substr($explain, 0, -1);
}