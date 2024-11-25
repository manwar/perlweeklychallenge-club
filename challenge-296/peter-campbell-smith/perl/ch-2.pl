#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-11-18
use utf8;     # Week 296 - task 2 - Matchstick square
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

matchstick_square(1, 2, 2, 2, 1);
matchstick_square(1, 3, 3, 3, 4, 5, 8, 9);
matchstick_square(20, 9, 3, 3, 7, 9, 3, 3, 7, 3, 3, 1, 3, 3, 7);
matchstick_square(5, 10, 5);
matchstick_square(2, 2, 2, 2, 4, 3);

sub matchstick_square {
	
	my (@ints, $sum, $no_good, @side, $m, $s, $try, $size, @result);
	
	# initialise
	@ints = @_;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	@ints = reverse sort {$a <=> $b} @ints;
	$no_good = 0;
	
	# see if the sum of the sticks is a multiple of 4 and that
	# the longest stick is no longer than a side of the square
	$sum += $_ for @ints;
	$size = int($sum / 4);
	if ($sum > 0 and $sum == 4 * $size and $ints[0] <= $size) {
		
		# loop over the 4 sides of the square
		for $s (0 .. 3) {
			$side[$s] = 0;
			
			# try to construct this side with the remaining matches
			for $m (0 .. $#ints) {
				next unless $ints[$m];
				$try = $side[$s] + $ints[$m];
				next if $try > $size;
				$side[$s] = $try;
				$result[$s] .= $ints[$m] . '+';
				$ints[$m] = 0;
				last if $side[$s] == $size;
			}
			
			# can't do it
			$no_good = 1 if $side[$s] ne $size;
			last if $no_good;
		}
		
		# report success
		unless ($no_good) {
			$result[$_] = substr($result[$_], 0, -1) for 0 .. 3;
			say qq[Output: true - sides are ] . join(', ', @result);
			return;
		}
	}
	# ... or failure
	say qq[Output: false];
}
