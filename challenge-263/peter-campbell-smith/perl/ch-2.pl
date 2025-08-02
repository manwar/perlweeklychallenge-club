#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-01
use utf8;     # Week 263 - task 2 - Merge items
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my (@items1, @items2, $j);

merge_items([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]);
merge_items([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]);
merge_items([[1, 1], [2, 2], [3, 3] ], [[2,3], [2, 4]]);

# larger example
for $j (0 .. 30) {
	push @items1, [int(rand(6)) + 1, int(rand(20)) + 1];
	push @items2, [int(rand(6)) + 1, int(rand(20)) + 1];
}

merge_items(\@items1, \@items2);

sub merge_items {
	
	my (@items, $j, $item, %quantity, @input, $output);
	
	# combine inventories
	@items = @_;
	for $j (0 .. 1) {
		for $item (@{$items[$j]}) {
			$quantity{$item->[0]} += $item->[1];
			$input[$j] .= qq{[$item->[0], $item->[1]], };
		}
	}
	
	# format output	
	$output .= qq{[$_, $quantity{$_}], } for (sort keys %quantity);
	say qq[\nInput:  \@items1 = ]  . substr($input[0], 0, -2) . qq[, \@items2 = ] . substr($input[1], 0, -2);
	say qq[Output: ] . substr($output, 0, -2);
}
