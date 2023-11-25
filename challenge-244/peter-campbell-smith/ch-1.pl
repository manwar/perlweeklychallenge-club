#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-11-20
use utf8;     # Week 244 task 1 - Count smaller
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

count_smaller(8, 1, 2, 2, 3);
count_smaller(0, 6, 5, 4, 8);

my @nums;
$nums[$_] = int(rand(100)) + 1 for 0 .. 99;
count_smaller(@nums);

sub count_smaller {
	
	my (@ints, @sorted, $i, $old_i, $count, %less_than, $result);
	
	# initialise
	@ints = @_;
	@sorted = sort {$a <=> $b} @ints;
	$count = 0;
	$old_i = -1;
	
	# create $less_than[$i] = number of $ints[$i] less than $i
	for $i (@sorted) {
		$less_than{$i} = $count if $i > $old_i;
		$count ++;
		$old_i = $i;
	}
	
	# format and output
	$result .= $less_than{$_} . ', ' for @ints;
	$result =~ s|..$||;
	
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output:         ($result)];
}