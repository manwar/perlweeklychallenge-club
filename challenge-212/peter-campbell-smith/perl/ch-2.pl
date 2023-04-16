#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-04-10
use utf8;     # Week 212 task 2 -
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

sequences(3, [8, 7, 3, 5, 2, 1, 0, 4, 6, 9]);
sequences(3, [1, 2, 3, 1, 2, 3, 2, 3, 4, 4, 5, 6]);
sequences(4, [4, 5, 6, 7, 123, 122, 121, 120, 120, 121, 122, 123]);

sub sequences {
	
	my ($length, @list, $j, @pool, $rubric, $good, $k);
	
	# initialise
	$length = $_[0];
	@list = sort {$a <=> $b} @{$_[1]};
	
	say qq[\nInput: \@list = (] . join(', ',@{$_[1]}) . qq[), length = $length];
	
	# make pool (see blog) - $pool[$j] is the no of $j's in $list
	for $j (0 .. scalar @list - 1) {
		$pool[$list[$j]] ++;
	}
	
	# start looping
	$j = $list[0];
	while (1) {
		
		# nothing left
		last if $j > $list[scalar @list - 1] - 2;
		
		# is there any a(nother) $j entry?
		$pool[$j] += 0;
		if ($pool[$j] > 0) {
		
			# is there a sequence starting here?
			$good = 1;
			for $k ($j .. $j + $length - 1) {
				$pool[$k] += 0;
				$good = 0 unless $pool[$k] > 0;
			}
			
			# yes there is
			if ($good) {
				$rubric .= '(';
				
				# take members of sequence out of pool
				for $k ($j .. $j + $length - 1) {
					$pool[$k] --;
					$rubric .= qq[$k, ];
				}
				$rubric = qq[] . substr($rubric, 0, -2) . q[), ];
			} else {
				say qq[Output: -1 ($j cannot be part of a substring)];
				return;
			}
		}
		
		# try next pool member unless there is another $j
		$j ++ unless $pool[$j];
	}
	say qq[Output: ] . substr($rubric, 0, -2);
}

