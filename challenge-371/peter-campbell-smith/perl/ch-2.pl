#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-04-27
use utf8;     # Week 371 - task 2 - Subset equilibrium
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use Algorithm::Combinatorics ('subsets');

subset_equilibrium(2, 1, 4, 3); 
subset_equilibrium(3, 0, 3, 0);
subset_equilibrium(5, 1, 1, 1);
subset_equilibrium(3, -1, 4, 2);
subset_equilibrium(10, 20, 30, 40);
subset_equilibrium(0, 3, 11, 2, -2, 4);

sub subset_equilibrium {
	
	my (@input, %in_index, $iter, $no, $ss, $sum_val, $sum_pos, @values, @positions, $j, $k, $output,
		$subsets, $details, @indices);
	
	# initialise
	@input = @_;
	
	# put 1-based positions into array and get subsets
	push @indices, $_ + 1 for 0 .. @input - 1;
	$iter = subsets(\@indices);
	
	# iterate over subsets
	$no = 1;
	$subsets = $details = '';
	while ($ss = $iter->next) { 
		next if @$ss <= 1 or @$ss == @indices;
		
		# add up values and positions for this subset
		$sum_val = $sum_pos = 0;
		@values = @positions = ();
		for $j (0 .. @$ss - 1) {
			$k = $ss->[$j] - 1;
			push @values, $input[$k];
			push @positions, $indices[$k];
			$sum_val += $input[$k];
			$sum_pos += $indices[$k];
		}
		
		# discard unless sum of values = sum of positions
		next unless $sum_val == $sum_pos;
		$subsets .= '(' . join(', ', @values) . '), ';
		$details .= 
			qq[\n   subset $no: (] . join(', ', @values) . ')' .
			qq[\n      values: ] . join(' + ', @values) . ' = ' . $sum_val . 
			qq[\n      positions: ] . join(' + ', @positions) . ' = ' . $sum_pos;  
		$no ++;
	}
	
	# report
	say qq[\nInput:  (] . join(', ', @input) . ')';
	print qq[Output: ] . ($subsets ? substr($subsets, 0, -2) . qq[$details\n] : qq[none\n]);
}
