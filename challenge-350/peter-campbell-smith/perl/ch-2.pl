#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-01
use utf8;     # Week 350 - task 2 - Shuffle pairs
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

shuffle_pairs(1, 1000, 1);
shuffle_pairs(1500, 2500, 1);
shuffle_pairs(1_000_000, 1_500_000, 5);
shuffle_pairs(13_427_000, 14_100_000, 2);
shuffle_pairs(1030, 1130, 1);

sub shuffle_pairs {
	
	my ($from, $to, $count, $A, $B, $a_sorted, $b_sorted, 
		$b_max, $witness, %results, %occurs, %legend, 
		$output, $explain);
	
	# initialise
	 ($from, $to, $count) = @_;
	 
	 # loop over given A values
	 for $A ($from .. $to) {
		next unless $A =~ m|^[1234]|;
		$a_sorted = join('', sort(split('', $A)));
		$b_max = 10 ** length($A);
		 
		# loop over possible witness and B values
		for $witness (2 .. 9) {
			$B = $A * $witness;
			last if $B >= $b_max;
			
			# check if A and B are anagrams
			$b_sorted = join('', sort(split('', $B)));
			if ($a_sorted eq $b_sorted) {
				$occurs{$A} ++;
				$results{$A} .= qq[$witness,$B; ];
			}
		}	 
	}
	
	# report
	for $A (keys %results) {
		while ($results{$A} =~ m|(\d+),(\d+);|g) {
			($witness, $B) = ($1, $2);
			$legend{$A} .= qq[ * $witness = $B;];
		}
	}
	$output = 0;
	for $A (keys %occurs) {
		next unless $occurs{$A} >= $count;
		$output ++;
		$explain .= qq[$A] . substr($legend{$A}, 0, -1) . 
			qq[\n];
	}
	
	say qq[\nInput:  \$from = $from, \$to = $to, \$count = $count];
	say qq[Output: $output];
	print $explain if $output;
}
