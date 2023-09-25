#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-09-25
use utf8;     # Week 236 task 2 - Array loops
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

array_loops(4, 6, 3, 8, 15, 0, 13, 18, 7, 16, 14, 19, 17, 5, 11, 1, 12, 2, 9, 10);
array_loops(0, 1, 13, 7, 6, 8, 10, 11, 2, 14, 16, 4, 12, 9, 17, 5, 3, 18, 15, 19);
array_loops(9, 8, 3, 11, 5, 7, 13, 19, 12, 4, 14, 10, 18, 2, 16, 1, 0, 15, 6, 17);

# generate bigger example
my ($j, @used, @ints, $count);
while (1) {
	$j = int(rand(100));
	next if $used[$j];
	push(@ints, $j);
	$used[$j] = 1;
	last if ++$count == 100;
}
array_loops(@ints);

sub array_loops {
	
	my (@ints, $j, $k, $m, $loops, $loop, $explain);
	
	# initialise
	@ints = @_;
	$loops = 0;
	
	# loop over next unused number
	for $j (0 .. scalar @ints - 1) {
		next unless defined $ints[$j];
		
		# loop over members of a loop, undefining numbers used
		$k = $j;
		while (1) {
			$m = $ints[$k];
			undef $ints[$k];
			$k = $m;
			last unless defined $k;
			$loop .= qq[$k ];
		}
		
		# details of this loop
		$loops ++;
		$explain .= qq/   [/ . substr($loop, 0, -1) . qq/]\n/;
		$loop = '';
	}
	
	# output results
	say qq[\nInput:  \@ints = (] . join(', ', @_) . ')';
	say qq[Output: $loops\n]  . substr($explain, 0, -1);
}
