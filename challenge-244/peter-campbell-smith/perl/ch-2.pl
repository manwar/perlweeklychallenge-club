#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-11-20
use utf8;     # Week 244 task 2 - Group hero
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use Algorithm::Combinatorics 'combinations';
my $details = 1;

group_hero(2, 1, 4);
group_hero(6, 8, 10);

$details = 0;
group_hero(1, 2, 4, 5, 7, 9, 11, 15, 19, 23, 30, 31, 39, 41, 47);

sub group_hero {
	
	my (@nums, $count, $sum, $c, $iter, $comb, $smallest, $largest, $i, $explain, $product);
	
	# initialise
	@nums = @_;
	$count = @_;
	$sum = 0;
	$explain = '';
	
	# loop over sizes of combination to consider
	for $c (1 .. $count) {
		
		# loop over combinations from @nums of that size
		$iter = combinations(\@nums, $c);
		while ($comb = $iter->next) {
			
			# get smallest and largest
			$smallest = 1e6;
			$largest = -1e6;
			for $i (0 .. $c - 1) {
				$smallest = $comb->[$i] if $comb->[$i] < $smallest;
				$largest = $comb->[$i] if $comb->[$i] > $largest;
			}
			
			# increment $sum
			$product = $smallest * $largest ** 2;
			$explain .= '   (' . join(', ', @$comb) . ') => ' . ($largest ** 2) . qq[ * $smallest = $product\n]
				if $details;
			$sum += $product
		}
	}

	# show results
	say qq[\nInput:  \@nums = (] . join(', ', @nums) . ')';
	say qq[Output: $sum\n] . substr($explain, 0, -1);
}