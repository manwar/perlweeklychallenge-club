#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 088 
#  				Task 2 - Largest Rectangle
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 11/22/2020 04:34:38 PM
#===============================================================================

use strict;
use warnings;
use List::Util qw/min/;

sub get_rectangle {
	my $input = shift;

	my @input_arr = @$input;

	my $x_size = scalar @input_arr;
	my $y_size = scalar @{$input_arr[0]};


	my $max_x=0;
	my $max_y=0;

	# loop through the array
	# look if the current element is 1
	# if so, check how far can go in the row and columns
	# if the rectangle is largest, save the dimensions
	for my $r (0..$x_size - 2) {
		for my $c (0..$y_size - 2) {
			if ($input_arr[$r][$c]) {
				my $size1 = 0;
				my $size2 = 0;

				while ($input_arr[$r+$size1][$c]) {

					#scan through the column and see what is the min size
					my $y_shift = 1;
					$y_shift++ while ($input_arr[$r+$size1][$c+$y_shift]);

					$size2 = $size2 ? min($size2, $y_shift) : $y_shift;
					
					last if $size2 == 1;

					$size1++;
				}

				if (($size1 * $size2) > ($max_x * $max_y)) {
					$max_x = $size1;
					$max_y = $size2;
				}

			}
		}
	}


	# print and return the results
	unless ($max_x * $max_y > 1) {
		print "0\n";
		return 0;
	}

	for my $i (0..$max_x-1) {
		print '[ ';
		for my $j (0..$max_y-1) {
			print '1 ';
		}
		print "]\n";
	}
	return [$max_x, $max_y];
}

use Test::More;

is_deeply(get_rectangle([[0,0,0,1,0,0],[1,1,1,0,0,0],[0,0,1,0,0,1],[1,1,1,1,1,0],[1,1,1,1,1,0]]), [2, 5]);
is_deeply(get_rectangle([[1,0,1,0,1,0],[0,1,0,1,0,1],[1,0,1,0,1,0],[0,1,0,1,0,1]]), 0);
is_deeply(get_rectangle([[0,0,0,1,1,1],[1,1,1,1,1,1],[0,0,1,0,0,1],[0,0,1,1,1,1],[0,0,1,1,1,1]]), [2, 4]);
done_testing;
