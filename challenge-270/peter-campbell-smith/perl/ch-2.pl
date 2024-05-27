#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-05-20
use utf8;     # Week 270 - task 2 - Distribute elements
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

distribute_elements([4, 1], 3, 2);
distribute_elements([2, 3, 3, 3, 5], 2, 1);
distribute_elements([2, 3, 3, 3, 5], 2, 5);
distribute_elements([7, 7, 7, 7, 7], 2, 1);
distribute_elements([2, 3, 3, 3, 5], 2, 5);

sub distribute_elements {
	
	my ($list_ref, @list, $x, $y, $largest, $bought_x, $bought_y);

	# initialise
	($list_ref, $x, $y) = @_;
	@list = sort {$a <=> $b} @$list_ref;
	$largest = $bought_x = $bought_y = 0;
	$largest = ($_ > $largest ? $_ : $largest) for @list;
	
	# if $y is not a bargain just buy lots of $x
	if ($y > 2 * $x) {
		$bought_x += $largest - $_ for @list;
	
	# buy until all values match the largest
	} else {
		while ($list[0] != $largest) {
			
			# can buy $y and add 1 to two smallest values
			if ($list[1] < $largest) {
				$bought_y ++;
				$list[0] ++;
				$list[1] ++;
				
			# only one value needs incrementing so buy an $x	
			} else {
				$bought_x ++;
				$list[0] ++;
			}
			@list = sort {$a <=> $b} @list;
		}
	}

	printf(qq[\nInput:  \@list = (%s), \$x = %d, \$y = %d\n], join(', ', @$list_ref), $x, $y);
	printf(qq[Output: %d (%d * \$x + %d * \$y)\n], $bought_x * $x + $bought_y * $y, $bought_x, $bought_y);
}
