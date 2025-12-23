#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-12-15
use utf8;     # Week 352 - task 2 - Binary prefix
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

binary_prefix(0, 1, 1, 0, 0, 1, 0, 1, 1, 1);
binary_prefix(1, 0, 1, 0, 1, 0);
binary_prefix(0, 0, 1, 0, 1);
binary_prefix(1, 1, 1, 1, 1);
binary_prefix(1, 0, 1, 1, 0, 1, 0, 0, 1, 1);
my @nums;
push @nums, 1 for 1 .. 63;
binary_prefix(@nums);

sub binary_prefix {
	
	my (@nums, $sum, $j, $output);
	
	# initialise
	@nums = @_;
	$sum = 0;
	
	# loop over @nums
	for $j (0 .. @nums - 1) {
		
		# add $nums[$j], ie 0 or 1
		$sum += $nums[$j];
		
		# true if $sum is a multiple of 5, else false
		$output .= ($sum =~ m|[05]$| ? 'true' : 'false') . qq[ ($sum), ];
		
		# shift $sum left
		$sum *= 2;
	}	
	
	say qq[\nInput:  (] . join(', ', @nums) . q[)];
	say qq[Output: ] . substr($output, 0, -2);
}
