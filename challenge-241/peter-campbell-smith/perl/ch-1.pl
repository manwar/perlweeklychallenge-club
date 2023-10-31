#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-30
use utf8;     # Week 241 task 1 - Arithmetic triplets
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

arithmetic_triplets ([0, 1, 4, 6, 7, 10], 3);
arithmetic_triplets ([(4, 5, 6, 7, 8, 9)], 2);

# generate 200 sorted unique numbers in (0 .. 1999)
my ($j, @nums, $next, $count, @used);
$count = 0;
while ($count < 200) {
	$next = int(rand(2000));
	next if $used[$next];
	push(@nums, $next);
	$count ++;
	$used[$next] = 1;
}
@nums = sort { $a <=> $b } @nums;
arithmetic_triplets (\@nums, 19);

sub arithmetic_triplets {
	
	my (@nums, $diff, $last, $i, $j, $k, $count, $explain, $ji_diff, $kj_diff);
	
	# initialise
	@nums = @{$_[0]};
	$diff = $_[1];
	$last = @nums - 1;
	
	# loop over triplets
	$explain = '';
	$count = 0;
	
	# loop over i any i (except the last 2) could be part of a triplet
	for $i (0 .. $last - 2) {
		
		# loop over j
		for $j (1 .. $last - 1) {
			$ji_diff = $nums[$j] - $nums[$i];
			
			# if they differ by more than $diff then we can abandon this j
			last if $ji_diff > $diff;
			
			# unless this pair of i and j differ by $diff there's no need to check k
			next unless $ji_diff == $diff;
						
			# loop over k
			for $k (2 .. $last) {
				$kj_diff = $nums[$k] - $nums[$j];
				
				# we can abandon this k if k differs from j by more than $diff
				last if ($kj_diff) > $diff;
				
				# and at last we've found an answer!
				if ($kj_diff == $diff) {
					$count ++;
					$explain .= qq{        \$nums[$i] = $nums[$i], \$nums[$j] = $nums[$j], \$nums[$k] = $nums[$k]\n};
				}
			}
		}
	}
	
	# show results
	say qq[\nInput:  \@nums = (] . join(q[, ], @nums) . q[)];
	say qq[        \$diff = $diff];
	say qq[Output: $count\n] . ($explain ? substr($explain, 0, -1) : '');
}
	