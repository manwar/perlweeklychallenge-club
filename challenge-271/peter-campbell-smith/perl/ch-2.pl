#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-05-27
use utf8;     # Week 271 - task 2 - Sort by 1 bits
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my @ints;

sort_by_1_bits(0, 1, 2, 3, 4, 5, 6, 7, 8);
sort_by_1_bits(1024, 512, 256, 128, 64);
sort_by_1_bits(1, 3, 7, 15, 31, 63, 127, 255, 511, 1023, 
	1048575, 987654321);

push(@ints, int(rand(50))) for 0 .. 50;
sort_by_1_bits(@ints);

sub sort_by_1_bits {
	
	my (@ints, $int, $j, @bits, %rank, $result);
	
	# loop over @ints
	@ints = @_;
	for $j (0 .. @ints - 1) {
		$int = $ints[$j];
		
		# get no of 1-bits in $int
		$bits[$j] = 0;
		for ($b = 1; $b <= $int; $b *= 2) {
			$bits[$j] ++ if $int & $b;
		}
		
		# rank them in the desired order
		$rank{sprintf('%02d', $bits[$j]) . 
			sprintf('%015d', $int) . 
			sprintf('%03d', $j)} = $int;
	}
	$result .= $rank{$_} . ', ' for sort keys %rank;	
	
	# show answer
	printf(qq[\nInput:  \@ints = (%s)\n], join(', ', @ints));
	printf(qq[Output:         (%s)\n], substr($result, 0, -2));
}
