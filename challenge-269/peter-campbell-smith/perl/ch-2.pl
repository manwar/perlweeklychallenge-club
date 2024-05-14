#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-05-13
use utf8;     # Week 269 - task 2 - Distribute elements
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

distribute_elements(2, 1, 3, 4, 5);
distribute_elements(3, 2, 4);
distribute_elements(5, 4, 3, 8);
distribute_elements(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
distribute_elements(10, 9, 8, 7, 6, 5, 4, 3, 2, 1);

sub distribute_elements {

	my (@ints, @arr1, @arr2, $j, $arr);

	@ints = @_;
	
	# push the first two elements of @ints onto @arr1 and @arr2
	($arr1[0], $arr2[0]) = @ints[0 .. 1];
	$j = 2;
	
	# push subsequent elements of @ints onto @arr1 or @arr2 
	do {
		$arr = $arr1[-1] > $arr2[-1] ? \@arr1 : \@arr2;
		push @$arr, $ints[$j];
	} until ++ $j == @ints;
	
	printf(qq[\nInput:  \@ints = (%s)\n], join(', ', @ints));
	printf(qq[Output: (%s)\n], join(', ', (@arr1, @arr2)));
}
