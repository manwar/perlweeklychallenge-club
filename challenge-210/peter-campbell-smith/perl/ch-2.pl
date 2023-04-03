#!/usr/bin/perl

use v5.16;       # The Weekly Challenge - 2023-03-27
use utf8;        # Week 210 task 2 - Number collision
use strict;      # Peter Campbell Smith
use warnings;    # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my ($j, @list);

number_collision(2, 3, -1);
number_collision(3, 2, -4);
number_collision(1, -1);
number_collision(1, -1, 2, -2, 4, -4);
number_collision(12, -2, -9, -6, -12, 10, 6, 1, 1, -12, 14);

for $j (0 .. 10) {
	$list[$j] = int(rand(15)) - 7;
}
number_collision(@list);


sub number_collision {
	
	my (@list, $last, $size, $j, $k);
	
	# loop over all the numbers, setting them to 0 if they die
	@list = @_;
	while (1) {
		
		# loop over values
		$size = scalar @list;
		for $j (0 .. $size - 2) {
			
			# skip unless this is +ve and next is -ve
			$k = $j + 1;
			next unless ($list[$j] > 0 and $list[$k] < 0);
			
			# same absolute value - both die
			if (abs($list[$j]) == abs($list[$k])) {
				$list[$j] = $list[$k] = 0;
				
			# this kills next
			} elsif (abs($list[$j]) < abs($list[$k])) {
				$list[$j] = 0;
				
			# next kills this
			} else {
				$list[$k] = 0;
			}	
		}
		
		# eliminate zeroes and exit if nothing's changed
		@list = grep { $_ != 0 } @list;
		last if scalar @list == $size;
	}

	# show results
	say qq[\nInput:  \@list = (] . join(', ', @_) . q[)];
	say qq[Output: (] . join(', ', @list) . qq[)];
}
