#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-04-03
use utf8;     # Week 211 task 2 - Split same average
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use Algorithm::Combinatorics ('combinations');

my ($j, @data);

equal_means(1, 2, 3, 4, 5, 6, 7, 8);
equal_means(1, 3);
equal_means(10, 1, 7, 5, 3, 11, 8, 4, 2, 9);
equal_means(6, 3, 1, 9, 12, 25, 18, 20);
equal_means(8, 6, 3, 5, 1, 4, 2, 7);

for $j (0 .. 20) {
	$data[$j] = int(rand(15));
}
equal_means(@data);

sub equal_means {
	
	my (@array, $count, $mean, $sum, $count1, @array1, $mean1, $sum1, 
		$count2, $sum2, $mean2, $comb, $iter, $d, $array2p, $combs);
	
	# initialise
	@array = @_;
	($count, $sum, $mean) = stats(@array);
	
	# loop over sizes of @array1 to consider
	OUTER: for $count1 (1 .. int($count / 2)) {
		
		# loop over combinations from @array of that size
		$iter = combinations(\@array, $count1);
		while ($comb = $iter->next) {

			# calculate @array1 data
			$combs ++;
			@array1 = @$comb;
			($count1, $sum1, $mean1) = stats(@array1);
			
			# deduce @array2 data
			$count2 = $count - $count1;
			$sum2 = $sum - $sum1;
			$mean2 = $sum2 / $count2;
			
			# means match - result!
			if ($mean1 == $mean2) {
				
				# format and print
				$array2p = ', ' . join(', ', @array) . ', ';
				for $d (@array1) {
					$array2p =~ s|, $d,|,|;
				}
				say qq[\nInput:  (] . join(', ', @array) . q[)];
				say qq[Output: true];
				say qq[   array1: (] . join(', ', @array1) . q[)];
				say qq[   array2: (] . substr($array2p, 2, -2) . q[)];
				say qq[   mean = $mean1 (after $combs combinations tested)];
				return;
			}
		}
	}
	say qq[\nInput:  (] . join(', ', @array) . q[)];
	say qq[Output: false (after $combs combinations tested)];
}

sub stats {
	
	my ($sum, $count, $d);
	
	$sum = $count = 0;
	for $d (@_) {
		$sum += $d;
		$count ++;
	}
	return ($count, $sum, $sum / $count);
}
		