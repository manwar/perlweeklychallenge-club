#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-05-19
use utf8;     # Week 322 - task 2 - Rank array
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use List::Util 'min';

rank_array(55, 22, 44, 33);
rank_array(10, 10, 10);
rank_array(5, 1, 1, 4, 3);
rank_array(0);
rank_array(-3, -3, -3, -2, -2, -1, 0);

# bigger example
my @array;
push @array, int(rand(100)) for 0 .. 25;
rank_array(@array);

sub rank_array {
	
	my (@array, @rank, @ranking, $n, $j, %numbers, $min);
	
	# initialise
	@array = @_;
	
	# to cope with -ve numbers
	$min = min(@array);
	
	# make # with keys of unique numbers
	$numbers{$_} = 1 for @array;
	
	# rank the numbers smallest to largest
	$j = 1;
	$rank[$_ - $min] = $j ++ for sort {$a <=> $b} keys %numbers;
	
	# assign the ranks to @ranking in the original order
	$ranking[$_] = $rank[$array[$_] - $min] for 0 .. $#array;
	
	say qq[\nInput:  (] . join(', ', @array) . q[)];
	say qq[Output: (] . join(', ', @ranking) . q[)];
}

